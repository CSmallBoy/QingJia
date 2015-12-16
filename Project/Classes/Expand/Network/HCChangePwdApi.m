//
//  HCChangePwdRequest.m
//  HealthCloud
//
//  Created by Jessie on 15/10/9.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCChangePwdApi.h"

@implementation HCChangePwdApi


- (NSString *)requestUrl
{
    return @"logon/changepwd";
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"X-Access-Token" : [HCAccountMgr manager].loginInfo.accessToken};
}

- (id)requestArgument
{
    return @{@"originalPwd" : _originalPwd,
             @"newPwd"      : _password};
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = @"";
    
    switch (statusCode) {
        case HCRequestStatusLoginUserPasswordNotRight:
            msg = @"原密码不正确";
            break;
        default:
            break;
    }
    
    return msg;
}

@end
