//
//  PMStepMoveView.m
//  PMedical
//
//  Created by Vincent on 15/6/2.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCStepMoveView.h"

#define LARGE_MARG   5.0f
#define VIEW_HEIGHT  44.f
#define ROUND_WIDTH  12.0f
#define END_MARK_WIDTH 20.0f
#define LINE_HEIGHT    2.0f

#define MTIT_WIDTH    80.0f
#define MTIT_HEIGHT   24.0f


#define ROUND_FALG     1000
#define LABEL_FALG     2000

@implementation HCStepMoveView
{
    UILabel     *_grayLine;
    UILabel     *_movedLine;
    UIImageView *_successImageView;
    NSUInteger  _lastIndex;
}
@synthesize stepTitles = _stepTitles;
@synthesize currentStep = _currentStep;

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = VIEW_HEIGHT;
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}


- (void)setStepTitles:(NSArray *)stepTitles
{
    _stepTitles = [NSArray arrayWithArray:stepTitles];
    
    NSUInteger num = _stepTitles.count;
    
    if (_successImageView) {
        [self removeAllSubviews];
        _successImageView = nil;
        _movedLine = nil;
    }
    
    NSUInteger appWidth = WIDTH(self);
    if (num > 1) {
        NSUInteger setpWidth = (appWidth - LARGE_MARG * 2) / num;
        NSUInteger originX = LARGE_MARG + setpWidth/2;
 
        //灰线
        CGRect rect = CGRectMake(originX, (END_MARK_WIDTH-LINE_HEIGHT)/2, appWidth - LARGE_MARG * 2 - setpWidth, LINE_HEIGHT);
        _grayLine = [[UILabel alloc] initWithFrame:rect];
        _grayLine.clipsToBounds = YES;
        _grayLine.backgroundColor = UIColorFromRGB(0xBDBDBD);
        ViewRadius(_grayLine, 1);
        [self addSubview:_grayLine];
        
        //绿线
        rect = _grayLine.bounds;
        rect.origin.x = -rect.size.width;
        _movedLine = [[UILabel alloc] initWithFrame:rect];
        _movedLine.backgroundColor = kHCNavBarColor;
        ViewRadius(_movedLine, 1);
        [_grayLine addSubview:_movedLine];
        
        for (int i = 0; i < _stepTitles.count; i++) {
            //圆点
            UILabel *roundView = [[UILabel alloc] initWithFrame:CGRectMake(originX-ROUND_WIDTH/2+setpWidth*i, (END_MARK_WIDTH-ROUND_WIDTH)/2, ROUND_WIDTH, ROUND_WIDTH)];
            roundView.tag = ROUND_FALG + i;
            roundView.backgroundColor = UIColorFromRGB(0xBDBDBD);
            ViewRadius(roundView, ROUND_WIDTH/2);
            [self addSubview:roundView];
            
            //文字
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX - MTIT_WIDTH/2 + setpWidth*i, VIEW_HEIGHT-MTIT_HEIGHT, MTIT_WIDTH, MTIT_HEIGHT)];
            titleLabel.tag = LABEL_FALG+i;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = (i > 0) ? [UIColor grayColor] : UIColorFromRGB(0xF37132);
            titleLabel.font = [UIFont systemFontOfSize:12.f];
            titleLabel.text = _stepTitles[i];
            [self addSubview:titleLabel];
            
        }
        //当前步骤标记图片
        _successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX-END_MARK_WIDTH/2, 0, END_MARK_WIDTH, END_MARK_WIDTH)];
        _successImageView.image = IMG(@"FindPwd-complete");
        [self addSubview:_successImageView];
    }
}

- (void)setCurrentStep:(NSUInteger)currentStep
{
    if (currentStep >= _stepTitles.count) {
        return;
    }
    _lastIndex = _currentStep;
    _currentStep = currentStep;
    [self moveToStep:_currentStep];
}

//移动到某一步
- (void)moveToStep:(NSUInteger)step
{
    if (step >= _stepTitles.count) {
        return;
    }
    _lastIndex = _currentStep;
    _currentStep = step;
    
    for (int i = 0; i < _stepTitles.count; i++) {
        
        UILabel *roundView = (UILabel *)[self viewWithTag:ROUND_FALG+i];
        UILabel *titleLabel = (UILabel *)[self viewWithTag:LABEL_FALG+i];
        if (i == _currentStep) {
            if (_currentStep < _lastIndex) {
                roundView.backgroundColor = kHCNavBarColor;
            }
        }
        else if (i < _currentStep) {
            roundView.backgroundColor = kHCNavBarColor;
            titleLabel.textColor = kHCNavBarColor;
        }
        else if (i > _currentStep) {
            roundView.backgroundColor = UIColorFromRGB(0xBDBDBD);
            titleLabel.textColor = UIColorFromRGB(0xBDBDBD);
        }
    }
    NSUInteger setpWidth = (WIDTH(self) - LARGE_MARG * 2) / _stepTitles.count;
    NSUInteger endX = LARGE_MARG + setpWidth/2 + _currentStep*setpWidth;
    
    CGRect lineFrame = _movedLine.frame;
    lineFrame.origin.x = _currentStep*setpWidth - lineFrame.size.width;
    CGPoint center = _successImageView.center;
    center.x = endX;
    
    [UIView animateWithDuration:.6 animations:^{
        _movedLine.frame = lineFrame;
        _successImageView.center = center;
    } completion:^(BOOL finished){
        UILabel *titleLabel = (UILabel *)[self viewWithTag:LABEL_FALG+_currentStep];
        titleLabel.textColor = UIColorFromRGB(0xF37132);
    }];
    
}



@end
