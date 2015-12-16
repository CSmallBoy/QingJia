//
//  HCGetUserInfoByTokenApi.h
//  HealthCloud
//
//  Created by Vincent on 15/11/4.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCUserInfoBlock)(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo);

@interface HCGetUserInfoByDeviceApi : HCRequest

@property (nonatomic, strong) NSString *deviceToken;

- (void)startRequest:(HCUserInfoBlock)requestBlock;

@end
