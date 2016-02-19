//
//  HCMergingFamilyImageView.m
//  Project
//
//  Created by 朱宗汉 on 16/2/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMergingFamilyImageView.h"

@implementation HCMergingFamilyImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.bounds];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH * 0.67, 50)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.3;
    UILabel * name_label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 50)];
    name_label.frame = CGRectMake(0, 180, SCREEN_WIDTH * 0.67, 50);
    name_label.text = @"幸福家庭";
    name_label.textAlignment = NSTextAlignmentCenter;
    name_label.textColor = [UIColor whiteColor];
    [self addSubview:image];
    [self addSubview:view];
    [self addSubview:name_label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
