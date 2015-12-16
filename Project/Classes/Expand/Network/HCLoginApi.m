//
//  HCLoginApi.m
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCLoginApi.h"

@implementation HCLoginApi

- (void)startRequest:(HCLoginBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = @"登录失败";
    
    switch (statusCode) {
        case HCRequestStatusSuccess:
            msg = @"登录成功";
            break;
        case HCRequestStatusLoginUserNotFound:
            msg = @"该用户不存在";
            break;
        case HCRequestStatusLoginUserPasswordNotRight:
            msg = @"密码不正确";
            break;
        default:
            break;
    }
    
    return msg;
}

- (id)formatResponseObject:(id)responseObject
{
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:responseObject];
    return loginInfo;
}

- (NSString *)requestUrl
{
    return @"logon/login";
}

- (id)requestArgument
{
    return @{@"uid"            : _mobile,
             @"pwd"            : _password,
             @"rid"            : @"patient",
             @"forAccessToken" : @YES
             };
}


@end
