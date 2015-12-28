//
//  HCNotificationViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationViewController.h"
#import "HCUnReadNotificationViewController.h"
#import "HCReadNotificationViewController.h"
#import "HCFollowNotificationViewController.h"
@interface HCNotificationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *closeFollowBtn;

@property (nonatomic,strong) HCUnReadNotificationViewController *unreadVC;
@property (nonatomic,strong) HCReadNotificationViewController *readVC;
@property (nonatomic,strong) HCFollowNotificationViewController *followVC;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation HCNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通知中心";
    [self.view addSubview:self.readVC.view];
    [self.view addSubview:self.segmented];
    [self setupBackItem];
    
    //添加左右滑动手势
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

#pragma mark -----私有方法

/**********左右滑动切换视图************/
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (self.segmented.selectedSegmentIndex != 2)
        {
            self.segmented.selectedSegmentIndex ++;
        }
        else if (self.segmented.selectedSegmentIndex == 2)
        {
            self.segmented.selectedSegmentIndex -= 2;
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (self.segmented.selectedSegmentIndex != 0)
        {
            self.segmented.selectedSegmentIndex --;
        }
        else if (self.segmented.selectedSegmentIndex == 0)
        {
            self.segmented.selectedSegmentIndex +=2;
        }
    }
    [self handleSegmentedControl:self.segmented];
}

-(void)clickCloseFollowBtn
{
    [self showHUDText:@"已找到孩子，关闭跟进"];
}

- (void)handleSegmentedControl:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        [self.followVC.view removeFromSuperview];
        [self.unreadVC.view removeFromSuperview];
        [self.view addSubview:self.unreadVC.view];
        [self.footerView removeFromSuperview];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        
        [self.followVC.view removeFromSuperview];
        [self.readVC.view removeFromSuperview];
        [self.view addSubview:self.readVC.view];
        [self.footerView removeFromSuperview];
    }else if (segment.selectedSegmentIndex == 2)
    {
        
        [self.followVC.view removeFromSuperview];
        [self.footerView removeFromSuperview];
        [self.view addSubview:self.followVC.view];
        [self.view addSubview:self.footerView];
    }
}


#pragma mark----Setter Or Getter

-(UISegmentedControl *)segmented
{
        if (!_segmented)
        {
            _segmented = [[UISegmentedControl alloc] initWithItems:@[@"未读信息", @"已读信息",@"跟进信息"]];
            _segmented.selectedSegmentIndex = 1;
            _segmented.frame = CGRectMake(20, 74, SCREEN_WIDTH-40, 30);
            _segmented.backgroundColor = [UIColor whiteColor];
            _segmented.tintColor = [UIColor redColor];
            [_segmented addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
        }
        return _segmented;
}

-(HCUnReadNotificationViewController *)unreadVC
{
    if (!_unreadVC) {
        _unreadVC = [[HCUnReadNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _unreadVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT-114);
        [self addChildViewController:_unreadVC];
    }
    return _unreadVC;
}

-(HCReadNotificationViewController *)readVC
{
    if (!_readVC) {
        _readVC = [[HCReadNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _readVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT-114);
        [self addChildViewController:_readVC];
    }
    return _readVC;
}

-(HCFollowNotificationViewController *)followVC
{
    if (!_followVC) {
        _followVC = [[HCFollowNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _followVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT-164);
        [self addChildViewController:_followVC];
    }
    return _followVC;
}


-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = RGB(236, 236, 236);
        [_footerView addSubview:self.closeFollowBtn];
    }
    return _footerView;
}

-(UIButton *)closeFollowBtn
{
    if (!_closeFollowBtn) {
        _closeFollowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeFollowBtn.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, 30);
        _closeFollowBtn.backgroundColor = [UIColor redColor];
        [_closeFollowBtn setTitle:@"已找到孩子，关闭跟进" forState:UIControlStateNormal];
        [_closeFollowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_closeFollowBtn, 10);
        _closeFollowBtn.titleLabel.font = FONT(14);
        [_closeFollowBtn addTarget:self action:@selector(clickCloseFollowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeFollowBtn;
}

@end
