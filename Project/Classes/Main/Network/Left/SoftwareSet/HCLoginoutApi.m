//
//  HCLoginoutApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLoginoutApi.h"

@implementation HCLoginoutApi

- (void)startRequest:(HCLoginoutBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/LoginOut.ashx";
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
