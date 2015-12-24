//
//  HCJoinGradeFunctionView.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCJoinGradeFunctionView.h"

@interface HCJoinGradeFunctionView()

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIImageView *scanImgView;
@property (nonatomic, strong) UIButton *scanButton;

@property (nonatomic, strong) UIImageView *joinImgView;
@property (nonatomic, strong) UIButton *joinButton;

@end

@implementation HCJoinGradeFunctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.scanImgView];
        [self.backgroundView addSubview:self.scanButton];
        
        [self.backgroundView addSubview:self.joinImgView];
        [self.backgroundView addSubview:self.joinButton];
    }
    return self;
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcjoinGradeFunctionViewSelectedType:)])
    {
        [self.delegate hcjoinGradeFunctionViewSelectedType:(HCJoinGradeFunctionViewButtonStype)button.tag];
    }
}

#pragma mark - setter or getter

- (UIImageView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
        _backgroundView.userInteractionEnabled = YES;
        _backgroundView.image = OrigIMG(@"joingrade");
    }
    return _backgroundView;
}

- (UIImageView *)scanImgView
{
    if (!_scanImgView)
    {
        _scanImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 20, 20)];
        _scanImgView.image = OrigIMG(@"inclass_ThinkChange");
    }
    return _scanImgView;
}

- (UIButton *)scanButton
{
    if (!_scanButton)
    {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanButton.frame = CGRectMake(MaxX(self.scanImgView), 20, WIDTH(self)-MaxX(self.scanImgView), 40);
        _scanButton.tag = HCJoinGradeFunctionViewButtonStypeScan;
        [_scanButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scanButton setTitle:@"扫描加入" forState:UIControlStateNormal];
        _scanButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _scanButton;
}

- (UIImageView *)joinImgView
{
    if (!_joinImgView)
    {
        _joinImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, MaxY(self.scanButton)+10, 20, 20)];
        _joinImgView.image = OrigIMG(@"inclass_2D-barcode");
    }
    return _joinImgView;
}

- (UIButton *)joinButton
{
    if (!_joinButton)
    {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinButton.frame = CGRectMake(MaxX(self.joinImgView), MaxY(self.scanButton), WIDTH(self.scanButton), 40);
        _joinButton.tag = HCJoinGradeFunctionViewButtonStypeJoin;
        [_joinButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_joinButton setTitle:@"名片加入" forState:UIControlStateNormal];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _joinButton;
}


@end
