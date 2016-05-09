//
//  HCHomeNotiButton.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHomeNotiButton.h"

@implementation HCHomeNotiButton

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
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
     _headimage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 2, 30, 30)];
    _label_image = [[UIImageView alloc]initWithFrame:CGRectMake(103, 2, 30, 30)];
    _label_image.image = IMG(@"1");
    //ViewBorderRadius(image, 25, 0, CLEARCOLOR);
    ViewRadius(_headimage, 5);
    _message_num = [[UILabel alloc]initWithFrame:CGRectMake(35, 2, 70, 30)];
    _message_num.textColor = [UIColor whiteColor];
    _message_num.font = [UIFont systemFontOfSize:12];
    [self addSubview:_view];
    [self addSubview:_headimage];
    [self addSubview:_message_num];
    [self addSubview:_label_image];
}
@end
