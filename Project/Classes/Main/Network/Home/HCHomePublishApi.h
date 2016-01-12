//
//  HCHomePublishApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
@class HCHomeInfo;
typedef void(^HCHomePublishBlock)(HCRequestStatus requestStatus, NSString *message, HCHomeInfo *homeInfo);

@interface HCHomePublishApi : HCRequest

- (void)startRequest:(HCHomePublishBlock)requestBlock;

@property (nonatomic, strong) NSString *FamilyID;
@property (nonatomic, strong) NSArray  *FTImages;// 图片数组 每一项用单引号包装起来,整体为一个字符串
@property (nonatomic, strong) NSString *FTContent; // 内容
@property (nonatomic, strong) NSString *OpenAddress; // 是否公开地址
@property (nonatomic, assign) NSString *PermitType; // 权限类型
@property (nonatomic, strong) NSArray  *PermitUserArr; // 不可见好友数组

@end
