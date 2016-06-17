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
    _backLabelFrame = CGRectMake(SCREEN_WIDTH-200, 15, 190, 25);// 此时显示的是回复评论的时间
    CGRect commentRect  = [commentInfo.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil];
    _commentLabelFrame = CGRectMake(70,45, SCREEN_WIDTH-120, commentRect.size.height);
        
    _button1Frame =  CGRectMake(70 , CGRectGetMaxY(_commentLabelFrame) + 10 , 70, 70);
    _button2Frame = CGRectMake(150,CGRectGetMaxY(_commentLabelFrame)+10,70 ,70);
    _button3Frame = CGRectMake(230,CGRectGetMaxY(_commentLabelFrame) + 10,70,70);
        
    if (commentInfo.imageNames)
    {

    }
    else
    {
        _button1Frame =  CGRectMake(70 , CGRectGetMaxY(_commentLabelFrame) + 10 , 0, 0);
        _button2Frame = CGRectMake(150,CGRectGetMaxY(_commentLabelFrame)+10,0 ,0);
        _button3Frame = CGRectMake(230,CGRectGetMaxY(_commentLabelFrame) + 10,0,0);
    }
    
    _locationImageFrame = CGRectMake(70, CGRectGetMaxY(_button1Frame)+5, 20, 23);
    _locationLabelFrame = CGRectMake(CGRectGetMaxX(_locationImageFrame)+5, CGRectGetMaxY(_button1Frame)+5, SCREEN_WIDTH-CGRectGetMaxX(_locationImageFrame)-5, 25);
    
    _cellHeight =CGRectGetMaxY(_locationLabelFrame) +10;

}

@end
