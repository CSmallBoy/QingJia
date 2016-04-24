//
//  HCPromisedCommentInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//  呼应 发现线索   评论模型

#import <Foundation/Foundation.h>

@interface HCPromisedCommentInfo : NSObject

@property (nonatomic,strong) NSString *fromId;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *phoneNo;
@property (nonatomic,strong) NSString *createLocation;
@property (nonatomic,strong) NSString *imageNames;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *toId;
@property (nonatomic,strong) NSString *toNickName;
@property (nonatomic,strong) NSString *isScan;
@end
