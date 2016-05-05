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
    
    if ([commentInfo.toId isEqualToString:commentInfo.oldId]) {
        _headBtnFrame = CGRectMake(10,5, 50, 50);
        _nickLabelFrame = CGRectMake(70, 15, 200, 25);
        
        _backLabelFrame = CGRectMake(SCREEN_WIDTH-200, 15, 190, 25);// 此时显示的是回复评论的时间
        
        CGRect commentRect  = [commentInfo.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil];
         _commentLabelFrame = CGRectMake(70,45, SCREEN_WIDTH-120, commentRect.size.height);
        
        _button1Frame =  CGRectMake(70 , CGRectGetMaxY(_commentLabelFrame) + 10 , 70, 70);
        _button2Frame = CGRectMake(150,CGRectGetMaxY(_commentLabelFrame)+10,70 ,70);
        _button3Frame = CGRectMake(230,CGRectGetMaxY(_commentLabelFrame) + 10,70,70);
        
        if (commentInfo.imageNames) {
            _readTextFildFrame = CGRectMake(10, CGRectGetMaxY(_button1Frame)+5, SCREEN_WIDTH-20, 30);
        }
        else
        {
            _readTextFildFrame = CGRectMake(10, CGRectGetMaxY(_commentLabelFrame)+5, SCREEN_WIDTH-20, 30);
        }
        
        _cellHeight =CGRectGetMaxY(_readTextFildFrame) +10;

    }else
    {
        _headBtnFrame = CGRectMake(10,5, 50, 50);
        _nickLabelFrame = CGRectMake(70, 15, 200, 25);
        _timeLabelFrame = CGRectMake(70,35, 200, 20);
        _backLabelFrame = CGRectMake(SCREEN_WIDTH-70, 15, 60, 25); // 此时显示的是回复两个字
        
        NSString *str = [NSString stringWithFormat:@"%@回复%@:%@",commentInfo.nickName,commentInfo.toNickName,commentInfo.content];
        
        CGRect commentRect  = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil];
        
        _commentLabelFrame = CGRectMake(70,55, SCREEN_WIDTH-120, commentRect.size.height);
        _button1Frame =  CGRectMake(70 , CGRectGetMaxY(_commentLabelFrame) + 10 , 50, 50);
        _button2Frame = CGRectMake(130,CGRectGetMaxY(_commentLabelFrame)+10,50 ,50);
        _button3Frame = CGRectMake(190,CGRectGetMaxY(_commentLabelFrame) + 10,50,50);
        
        if (commentInfo.imageNames) {
            
            _cellHeight = CGRectGetMaxY(_button1Frame)+10;
        }
        else
        {
            _cellHeight = CGRectGetMaxY(_commentLabelFrame)+10;
        }
        
    
    }
  
}

@end
