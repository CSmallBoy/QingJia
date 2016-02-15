//
//  HCPromisedCommentFrameInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedCommentFrameInfo.h"
#import "HCPromisedCommentInfo.h"




@implementation HCPromisedCommentFrameInfo

-(void)setCommentInfo:(HCPromisedCommentInfo *)commentInfo
{
    _commentInfo = commentInfo;
    _headBtnFrame = CGRectMake(10,5, 50, 50);
    _nickLabelFrame = CGRectMake(70, 15, 200, 25);
    _timeLabelFrame = CGRectMake(SCREEN_WIDTH-70, 15, 60, 25);
    
    CGRect commentRect  = [commentInfo.comment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil];
    
    _commentLabelFrame = CGRectMake(60, 59, SCREEN_WIDTH-120, commentRect.size.height);
    _button1Frame =  CGRectMake(60 , CGRectGetMaxY(_commentLabelFrame) + 10 , 50, 50);
    _button2Frame = CGRectMake(120,CGRectGetMaxY(_commentLabelFrame)+10,50 ,50);
    _button3Frame = CGRectMake(180,CGRectGetMaxY(_commentLabelFrame) + 10,50,50);
    
    _cellHeight = CGRectGetMaxY(_button3Frame) +10;

}

@end
