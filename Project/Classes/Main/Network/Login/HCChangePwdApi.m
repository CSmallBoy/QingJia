//
//  HCChangePwdRequest.m
//  HealthCloud
//
//  Created by 陈福杰 on 15/11/17.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCChangePwdApi.h"

@implementation HCChangePwdApi

- (void)startRequest:(HCChangePwdBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/ForgetPwd.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"FindPwd", @"UserName":_UserName, @"Token": _Token, @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *para = @{@"UserPWD": _UserPWD};
    NSDictionary *body = @{@"Head": head, @"Para": para};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}

@end
