//
//  HCCustomTagApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"



@class HCTagUserInfo;

typedef void(^HCResumeBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCCustomTagApi : HCRequest

@property (nonatomic, strong) HCTagUserInfo *info;

- (void)startRequest:(HCRequestBlock)requestBlock;

@end
