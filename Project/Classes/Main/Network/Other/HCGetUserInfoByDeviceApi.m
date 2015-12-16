//
//  HCGetUserInfoByTokenApi.m
//  HealthCloud
//
//  Created by Vincent on 15/11/4.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCGetUserInfoByDeviceApi.h"

@implementation HCGetUserInfoByDeviceApi

- (NSTimeInterval)requestTimeoutInterval
{
    return 45;
}



//
- (void)startRequest:(HCUserInfoBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *data = (NSDictionary *)responseObject;
    NSDictionary *body = data[@"body"];
    NSDictionary *user = body[@"user"];
    
    HCLoginInfo *userInfo = [HCLoginInfo mj_objectWithKeyValues:user];
    
    return userInfo;
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = @"";
    
    switch (statusCode) {
        case HCRequestStatusLoginInOtherDevice:
            msg = @"号已在其他设备登录～";
            break;
        default:
            msg = @"获取用户信息失败。";
            break;
    }
    
    return msg;
}


@end
