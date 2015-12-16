//
//  HCUserApi.h
//  Project
//
//  Created by 陈福杰 on 15/11/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCUserInfo;

typedef void(^HCUserBlock)(HCRequestStatus requestStatus, NSString *message, HCUserInfo *userinfo);

@interface HCUserApi : HCRequest

- (void)startRequest:(HCUserBlock)requestBlock;


@end
