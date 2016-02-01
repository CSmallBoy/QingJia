//
//  HCLeftView.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//   没有班级图片

#import "HCLeftView.h"

@interface HCLeftView()

@property (nonatomic, strong) UIButton *createGradeBtn;
@property (nonatomic, strong) UIButton *joinGradeBtn;

@property (nonatomic, strong) UIButton *sofewareSetBtn;
@property (nonatomic, strong) UIImageView *setImgView;

@end

@implementation HCLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGB(34, 35, 37);
        [self addSubview:self.headButton];
        [self addSubview:self.nickName];
        [self addSubview:self.createGradeBtn];
        [self addSubview:self.joinGradeBtn];
        [self addSubview:self.sofewareSetBtn];
    }
    return self;
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcleftViewSelectedButtonType:)])
    {
        [self.delegate hcleftViewSelectedButtonType:(HCLeftViewButtonType)button.tag];
    }
}

#pragma mark - setter or getter

- (UIButton *)headButton
{
    if (!_headButton)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.tag = HCLeftViewButtonTypeHead;
        [_headButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _headButton.frame = CGRectMake(WIDTH(self)*0.2, 50, 100, 100);
        ViewRadius(_headButton, 50);
        [_headButton setImage:OrigIMG(@"Circle-of-Friends") forState:UIControlStateNormal];
    }
    return _headButton;
}

- (UILabel *)nickName
{
    if (!_nickName)
    {
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor whiteColor];
        _nickName.frame = CGRectMake(WIDTH(self)*.2, MaxY(self.headButton)+10, 90, 20);
        _nickName.textAlignment = NSTextAlignmentCenter;
        _nickName.text = @"用户昵称";
    }
    return _nickName;
}

- (UIButton *)createGradeBtn
{
    if (!_createGradeBtn)
    {
        _createGradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _createGradeBtn.tag = HCLeftViewButtonTypeCreateGrade;
        [_createGradeBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_createGradeBtn setTitle:@"创建班级" forState:UIControlStateNormal];
        _createGradeBtn.frame = CGRectMake(WIDTH(self)*0.2, HEIGHT(self)*0.5, 90, 60);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 90, 1)];
        line.backgroundColor = RGB(50, 51, 52);
        [_createGradeBtn addSubview:line];
    }
    return _createGradeBtn;
}

- (UIButton *)joinGradeBtn
{
    if (!_joinGradeBtn)
    {
        _joinGradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinGradeBtn.tag = HCLeftViewButtonTypeJoinGrade;
        [_joinGradeBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_joinGradeBtn setTitle:@"加入班级" forState:UIControlStateNormal];
        _joinGradeBtn.frame = CGRectMake(WIDTH(self)*0.2, MaxY(self.createGradeBtn), 90, 60);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 90, 1)];
        line.backgroundColor = RGB(50, 51, 52);
        [_joinGradeBtn addSubview:line];
    }
    return _joinGradeBtn;
}

- (UIButton *)sofewareSetBtn
{
    if (!_sofewareSetBtn)
    {
        _sofewareSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sofewareSetBtn.tag = HCLeftViewButtonTypeSoftwareSet;
        [_sofewareSetBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_sofewareSetBtn setTitle:@"软件设置" forState:UIControlStateNormal];
        _sofewareSetBtn.frame = CGRectMake(WIDTH(self)*0.2, HEIGHT(self)-80, 120, 40);
        [_sofewareSetBtn addSubview:self.setImgView];
    }
    return _sofewareSetBtn;
}

- (UIImageView *)setImgView
{
    if (!_setImgView)
    {
        _setImgView = [[UIImageView alloc] initWithImage:OrigIMG(@"Settings")];
        _setImgView.frame = CGRectMake(0, 10, 20, 20);
    }
    return _setImgView;
}



@end
