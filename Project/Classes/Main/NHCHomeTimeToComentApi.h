//
//  NHCHomeTimeToComentApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface NHCHomeTimeToComentApi : HCRequest
@property (nonatomic,copy)NSString *Timesid;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *createLocation;
@property (nonatomic,copy)NSString *createAddrSmall;
@property (nonatomic,copy)NSString *ToUserId;
@property (nonatomic,copy)NSString *imageNames;
//发表评论
@property (nonatomic,copy)NSString *createAddr;
//评论的 parentCommentId   0 为顶层评论
@property (nonatomic,copy)NSString *parentCommentId;
@end
