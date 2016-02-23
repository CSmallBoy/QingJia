//
//  HCMergingFamilyView.m
//  Project
//
//  Created by 朱宗汉 on 16/2/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMergingFamilyView.h"

@implementation HCMergingFamilyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _up_label = [[UILabel alloc]initWithFrame:CGRectMake(22, 5, 40, 20)];
    _down_label = [[UILabel alloc]initWithFrame:CGRectMake(22 , SCREEN_HEIGHT - 25 -64, 40, 20)];
    _line_label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 2, SCREEN_HEIGHT - 64- 10)];
    _time_label = [[UILabel alloc]initWithFrame:CGRectMake(32, (SCREEN_HEIGHT-64)/2, 30, 20)];
    
    _line_label.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, (SCREEN_HEIGHT-64)/2, 20, 20)];
    ViewBorderRadius(image, 10, 0, CLEARCOLOR);
    
    image.image = [UIImage imageNamed:@"round"];
    [self addSubview:_up_label];
    [self addSubview:_down_label];
    [self addSubview:_line_label];
    [self addSubview:_time_label];
    [self addSubview:image];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
