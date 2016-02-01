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
    _headBtnFrame = CGRectMake(10, 5, SCREEN_WIDTH *0.1, SCREEN_WIDTH *0.1);
    _nickLabelFrame = CGRectMake(10 + SCREEN_WIDTH*0.1, 13, SCREEN_WIDTH*0.5, 25);
    _timeLabelFrame = CGRectMake(SCREEN_WIDTH*0.8, 13, SCREEN_WIDTH*0.2, 25);
    
     CGRect commentRect  = [commentInfo.comment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH * 0.1+20, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil];
    
    _commentLabelFrame = CGRectMake(SCREEN_WIDTH * 0.1+20, 13+25, SCREEN_WIDTH*0.7, commentRect.size.height);
    _button1Frame =  CGRectMake(SCREEN_WIDTH*0.1+20 +0 *((SCREEN_WIDTH * 0.7)/3) , 13 + 25 + commentRect.size.height , (SCREEN_WIDTH*0.7-2)/3, (SCREEN_WIDTH*0.7-2)/3);
    _button2Frame = CGRectMake(SCREEN_WIDTH*0.1+20 +1 *((SCREEN_WIDTH * 0.7)/3) , 13 + 25 + commentRect.size.height , (SCREEN_WIDTH*0.7-2)/3, (SCREEN_WIDTH*0.7-2)/3);
    _button3Frame = CGRectMake(SCREEN_WIDTH*0.1+20 +2 *((SCREEN_WIDTH * 0.7)/3) , 13 + 25 + commentRect.size.height , (SCREEN_WIDTH*0.7-2)/3, (SCREEN_WIDTH*0.7-2)/3);
    
    _cellHeight = CGRectGetMaxX(_button3Frame) +10;
    

}

@end
