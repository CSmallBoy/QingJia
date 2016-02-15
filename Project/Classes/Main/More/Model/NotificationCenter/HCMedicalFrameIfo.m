//
//  HCMedicalFrameIfo.m
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMedicalFrameIfo.h"
#import "HCMedicalInfo.h"


@implementation HCMedicalFrameIfo


-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleFrame = CGRectMake(10, 10, 60, 20);
    
    CGRect Rect  = [title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-70, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor blackColor]} context:nil];
    
    _contentFrame = CGRectMake(70, 10, Rect.size.width, Rect.size.height);
    
    _cellHeight = CGRectGetMaxY(_contentFrame)+ 10;

}

@end
