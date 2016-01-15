//
//  HCHomeLikeCountApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHomeLikeCountApi.h"

@implementation HCHomeLikeCountApi

- (void)startRequest:(HCHomeLikeCountBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"Like", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"TimesId": [Utils getNumberWithString:_TimesId]};
    NSDictionary *body = @{@"Head": head, @"Para": para};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}

@end
