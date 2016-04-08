//
//  HCUserHeadImageViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCUserHeadImageViewController.h"

@interface HCUserHeadImageViewController ()

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation HCUserHeadImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"头像";
    [self setupBackItem];
    
    [self.view addSubview:self.grayView];
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
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, WIDTH(self.view)-30, HEIGHT(self.view)*0.6)];
        _contentView.center = self.view.center;
        _contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_contentView, 5);
        [_contentView addSubview:self.headImgView];
    }
    return _contentView;
}

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (HEIGHT(self.view)*0.6-SCREEN_WIDTH)/2, SCREEN_WIDTH-30-30, SCREEN_WIDTH)];
        //头像
        _headImgView.image = [readUserInfo image64:_head_image];
    }
    return _headImgView;
}

@end
