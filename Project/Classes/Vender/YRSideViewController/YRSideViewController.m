//
//  YRSideViewController.m
//  YRSnippets
//
//  Created by 王晓宇 on 14-5-10.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRSideViewController.h"
#import "HCRootTabBarController.h"

@interface YRSideViewController ()<UIGestureRecognizerDelegate>
{
    UIView *_baseView;
    UIView *_currentView;
    
    UIPanGestureRecognizer *_panGestureRecognizer;
    
    CGPoint _startPanPoint;
    CGPoint _lastPanPoint;
    BOOL _panMovingRightOrLeft;//true是向右，false是向左
    
    UIButton *_coverButton;
}
@end

@implementation YRSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _leftViewShowWidth = 267;
        _animationDuration = 0.35;
        _showBoundsShadow = true;

        _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_panGestureRecognizer setDelegate:self];

        _panMovingRightOrLeft = true;
        _lastPanPoint = CGPointZero;

        _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_coverButton addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _baseView = self.view;
    _baseView.backgroundColor = [UIColor clearColor];
    self.needSwipeShowMenu = true;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_currentView!=_rootViewController.view)
    {
        [_currentView removeFromSuperview];
        _currentView=_rootViewController.view;
        [_baseView addSubview:_currentView];
        _currentView.frame=_baseView.bounds;
    }
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController!=rootViewController)
    {
        if (_rootViewController)
        {
            [_rootViewController removeFromParentViewController];
        }
        _rootViewController=rootViewController;
        if (_rootViewController)
        {
            [self addChildViewController:_rootViewController];
        }
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (_leftViewController!=leftViewController)
    {
        if (_leftViewController)
        {
            [_leftViewController removeFromParentViewController];
        }
        _leftViewController=leftViewController;
        if (_leftViewController)
        {
//            _leftViewController.view.frame = CGRectMake(0, HEIGHT(self.view)*0.5, WIDTH(self.view)*0.5, HEIGHT(self.view)*0.5);//////
            [self addChildViewController:_leftViewController];
        }
    }
}

- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu
{
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu)
    {
        [_baseView addGestureRecognizer:_panGestureRecognizer];
    }else
    {
        [_baseView removeGestureRecognizer:_panGestureRecognizer];
    }
}

- (void)showShadow:(BOOL)show
{
    _currentView.layer.shadowOpacity    = show ? 0.8f : 0.0f;
    if (show)
    {
        _currentView.layer.cornerRadius = 4.0f;
        _currentView.layer.shadowOffset = CGSizeZero;
        _currentView.layer.shadowRadius = 4.0f;
        _currentView.layer.shadowPath   = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
}

#pragma mark  ShowOrHideTheView

- (void)willShowLeftViewController
{
    if (!_leftViewController || _leftViewController.view.superview)
    {
        return;
    }
    
    [_baseView insertSubview:_leftViewController.view belowSubview:_currentView];
}

- (void)showLeftViewController:(BOOL)animated{
    if (!_leftViewController)
    {
        return;
    }
    [self willShowLeftViewController];
    
    NSTimeInterval animatedTime=0;
    if (animated)
    {
        animatedTime = ABS(_leftViewShowWidth - _currentView.frame.origin.x) / _leftViewShowWidth * _animationDuration;
    }
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView animateWithDuration:animatedTime animations:^
    {
        [self layoutCurrentViewWithOffset:_leftViewShowWidth];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];
}

- (void)hideSideViewController:(BOOL)animated
{
    self.showStatus = NO;
    [self showShadow:false];
    NSTimeInterval animatedTime = 0;
    if (animated)
    {
        animatedTime = ABS(_currentView.frame.origin.x / (_currentView.frame.origin.x>0?_leftViewShowWidth:_rightViewShowWidth)) * _animationDuration;
    }
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView animateWithDuration:animatedTime animations:^
    {
        [self layoutCurrentViewWithOffset:0];
        
    } completion:^(BOOL finished)
     {
        [_coverButton removeFromSuperview];
        [_leftViewController.view removeFromSuperview];
    }];
}

- (void)hideSideViewController
{
    [self hideSideViewController:true];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panGestureRecognizer)
    {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:_baseView];
        
        if ([panGesture velocityInView:_baseView].x < 600 && ABS(translation.x)/ABS(translation.y)>1)
        {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)pan:(UIPanGestureRecognizer*)pan
{
    HCRootTabBarController *tab = (HCRootTabBarController *)_rootViewController;
    UINavigationController *nav = _rootViewController.childViewControllers[tab.selectedIndex];
    
    if (![nav.visibleViewController.view isEqual:_homeView])
    {
        return;
    }
    
    if (_panGestureRecognizer.state==UIGestureRecognizerStateBegan)
    {
        _startPanPoint=_currentView.frame.origin;
        if (_currentView.frame.origin.x==0)
        {
            [self showShadow:_showBoundsShadow];
        }
        
        CGPoint velocity=[pan velocityInView:_baseView];
        if(velocity.x>0)
        {
            if (_currentView.frame.origin.x>=0 && _leftViewController && !_leftViewController.view.superview)
            {
                [self willShowLeftViewController];
                self.showStatus = YES;
            }
        }else if (velocity.x<0)
        {
        }
        return;
    }
    
    CGPoint currentPostion = [pan translationInView:_baseView];
    CGFloat xoffset = _startPanPoint.x + currentPostion.x;
    
    if (xoffset>0) //向右滑
    {
        if (_leftViewController && _leftViewController.view.superview)
        {
            xoffset = xoffset>_leftViewShowWidth?_leftViewShowWidth:xoffset;
        }else
        {
            xoffset = 0;
        }
    }else if(xoffset<0) //向左滑
    {
            xoffset = 0;
    }
    
    if (xoffset!=_currentView.frame.origin.x)
    {
        [self layoutCurrentViewWithOffset:xoffset];
    }
    
    if (_panGestureRecognizer.state==UIGestureRecognizerStateEnded)
    {
        if (_currentView.frame.origin.x!=0 && _currentView.frame.origin.x!=_leftViewShowWidth && _currentView.frame.origin.x!=-_rightViewShowWidth)
        {
            if (_panMovingRightOrLeft && _currentView.frame.origin.x>20)
            {
                [self showLeftViewController:true];
            }else if(!_panMovingRightOrLeft && _currentView.frame.origin.x<-20)
            {
                
            }else
            {
                [self hideSideViewController];
            }
        }else if (_currentView.frame.origin.x==0)
        {
            [self showShadow:false];
        }
        _lastPanPoint = CGPointZero;
    }else
    {
        CGPoint velocity = [pan velocityInView:_baseView];
        if (velocity.x>0)
        {
            _panMovingRightOrLeft = true;
        }else if(velocity.x<0)
        {
            _panMovingRightOrLeft = false;
        }
    }
}

// 重写此方法可以改变动画效果,PS._currentView就是RootViewController.view

- (void)layoutCurrentViewWithOffset:(CGFloat)xoffset
{
    /* 平移的动画
     [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y, _baseView.frame.size.width, _baseView.frame.size.height)];
    return;
    */
    
    // 平移带缩放效果的动画
    static CGFloat h2w = 0;
    if (h2w==0)
    {
        h2w = _baseView.frame.size.height/_baseView.frame.size.width;
    }
    
    CGFloat scale = ABS(1400 - ABS(xoffset)) / 1400;
    scale = MAX(0.8, scale);
    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat totalWidth=_baseView.frame.size.width;
    CGFloat totalHeight=_baseView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        totalHeight=_baseView.frame.size.width;
        totalWidth=_baseView.frame.size.height;
    }
    
    if (xoffset>0) // 向右滑的
    {
        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
        
//        CGFloat scales = ABS(_leftViewShowWidth - ABS(xoffset)) / _leftViewShowWidth;
//        [_leftViewController.view setFrame:CGRectMake(-WIDTH(self.view)+WIDTH(self.view)*(1 - scales), 0, WIDTH(self.view)*(1 - scales), HEIGHT(self.view)*(1 - scales))];
    }else // 向左滑的
    {
        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }
}


@end
