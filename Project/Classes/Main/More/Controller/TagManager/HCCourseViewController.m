//
//  HCCourseViewController.m
//  蒙版
//
//  Created by 陈福杰 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCourseViewController.h"
#import "MDCFocusView.h"
#import "MDCSpotlightView.h"

@interface HCCourseViewController ()


@property (nonatomic, strong) UIView *stepOneView;
@property (nonatomic, strong) UILabel *stepOne;

@property (nonatomic, strong) UIView *stepTwoView;
@property (nonatomic, strong) MDCFocusView *focusView;
@property (nonatomic, strong) UIView *lightCircle;

@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation HCCourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.stepOneView];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([self.stepOneView isEqual:tap.view])
    {
        [self.stepOneView removeFromSuperview];
    }
    
    if (self.stepOne.tag == 100)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
   [self.view addSubview:self.stepTwoView];
    if ([self.stepTwoView isEqual:tap.view])
    {
        self.stepOne.frame = CGRectMake(0, CGRectGetMaxY(self.arrowImgView.frame), self.view.frame.size.width, 80);
        self.stepOne.text = @"点击图标对\n被铁物和标签进行拍照上传\n上传照片方便记忆管理哦！";
        self.stepOne.tag = 100;
    }

}

- (UIView *)stepTwoView
{
    if (!_stepTwoView)
    {
        _stepTwoView = [[UIView alloc] initWithFrame:self.view.frame];
        _stepTwoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_stepTwoView addGestureRecognizer:tap];
        [_stepTwoView addSubview:self.focusView];
    }
    return _stepTwoView;
}

- (MDCFocusView *)focusView
{
    if (!_focusView)
    {
        _focusView = [[MDCFocusView alloc] init];
        _focusView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.80f];
        _focusView.focalPointViewClass = [MDCSpotlightView class];
        
        [_focusView focus:self.lightCircle, nil];
        [_focusView addSubview:self.arrowImgView];
        
        self.stepOne.frame = CGRectMake(0, CGRectGetMaxY(self.arrowImgView.frame), self.view.frame.size.width, 30);
        self.stepOne.text = @"点击图标进行扫描激活";
        [_focusView addSubview:self.stepOne];
    }
    return _focusView;
}

- (UIView *)lightCircle
{
    if (!_lightCircle)
    {
        _lightCircle = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width*0.4, self.view.frame.size.width/4, self.view.frame.size.width/4)];
        _lightCircle.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }
    return _lightCircle;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.1, CGRectGetMaxY(self.lightCircle.frame)+50, 80, 80)];
        _arrowImgView.image = [UIImage imageNamed:@"fx_guide_arrow_down"];
    }
    return _arrowImgView;
}

- (UIView *)stepOneView
{
    if (!_stepOneView)
    {
        _stepOneView = [[UIView alloc] initWithFrame:self.view.frame];
        _stepOneView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [_stepOneView addSubview:self.stepOne];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_stepOneView addGestureRecognizer:tap];
    }
    return _stepOneView;
}

- (UILabel *)stepOne
{
    if (!_stepOne)
    {
        _stepOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _stepOne.textColor = [UIColor whiteColor];
        _stepOne.numberOfLines = 0;
        _stepOne.center = self.view.center;
        _stepOne.text = @"请将需要激活的标签都烫印\n相应的衣物或者其他随身物品上";
        _stepOne.font = [UIFont systemFontOfSize:20];
        _stepOne.textAlignment = NSTextAlignmentCenter;
    }
    return _stepOne;
}


@end
