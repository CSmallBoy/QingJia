//
//  HCUserHeadImageViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCUserHeadImageViewController.h"

@interface HCUserHeadImageViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation HCUserHeadImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"头像";
    [self setupBackItem];
    [self.view addSubview:self.grayView];
    //缩放
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)];
    pin.delegate = self;
    [self.contentView addGestureRecognizer:pin];
    //移动
    UIPanGestureRecognizer *pan  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    //pan.delegate = self;
    self.headImgView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:pan];
}
-(void)pan:(UIPanGestureRecognizer*)panSender{
    UIView *panView = self.headImgView;
    CGPoint translation = [panSender translationInView:panView.superview];
    panView.center=CGPointMake(panView.center.x+translation.x, panView.center.y+translation.y);
    [panSender setTranslation:(CGPointMake(0, 0))inView:panView.superview];
}
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = self.headImgView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}
#pragma mark - private methods

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self.grayView];
    if (!CGRectContainsPoint(self.contentView.frame, tapPoint))
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - setter or getter

- (UIView *)grayView
{
    if (!_grayView)
    {
        _grayView = [[UIView alloc] initWithFrame:self.view.frame];
        _grayView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [_grayView addSubview:self.contentView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_grayView addGestureRecognizer:tap];
    }
    return _grayView;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
        _contentView.center = self.view.center;
        //_contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_contentView, 5);
        self.headImgView.clipsToBounds = YES;
        self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_contentView addSubview:self.headImgView];
    }
    return _contentView;
}

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 100, WIDTH(self.view)-30, HEIGHT(self.view)*0.6)];
        //头像
        [_headImgView sd_setImageWithURL:[readUserInfo originUrl:_head_image :kkUser] placeholderImage:IMG(@"drg160.png")];
    }
    return _headImgView;
}

@end
