//
//  HCLogoutApi.m
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCLogoutApi.h"

@implementation HCLogoutApi

- (void)startRequest:(HCLoginoutBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/Login.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"LoginOut", @"UserName": [HCAccountMgr manager].loginInfo.UserName, @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *body = @{@"Head": head};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
