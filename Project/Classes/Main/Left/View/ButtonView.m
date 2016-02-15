//
//  ButtonView.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    image.image = [UIImage imageNamed:@"image_hea.jpg"];
    ViewBorderRadius(image, 25, 0, CLEARCOLOR);
    UILabel *name_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 50, 20)];
    [self addSubview:image];
    [self addSubview:name_label];
}
@end
