//
//  HCPromisedCommentFrameInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//   呼应 发现线索的 评论Frame模型

#import <Foundation/Foundation.h>

@class HCPromisedCommentInfo;
@interface HCPromisedCommentFrameInfo : NSObject

@property (nonatomic,strong) HCPromisedCommentInfo  *commentInfo;

@property (nonatomic,assign) CGRect  headBtnFrame;
@property (nonatomic,assign) CGRect  nickLabelFrame;
@property (nonatomic,assign) CGRect  commentLabelFrame;
@property (nonatomic,assign) CGRect  timeLabelFrame;
@property (nonatomic,assign) CGRect  button1Frame;
@property (nonatomic,assign) CGRect  button2Frame;
@property (nonatomic,assign) CGRect  button3Frame;

@property (nonatomic,assign) CGRect  readTextFildFrame;

@property(nonatomic,assign) CGFloat  cellHeight;

@end
