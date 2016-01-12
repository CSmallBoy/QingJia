//
//  HCHomeApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeApi.h"
#import "HCHomeInfo.h"

@implementation HCHomeApi

- (void)startRequest:(HCHomeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"GetList", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid};
    NSDictionary *result = @{@"Start":@([_Start integerValue]), @"Count": @(20)};
    NSDictionary *body = @{@"Head": head, @"Result": result};
    
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"][@"rows"];
    return [HCHomeInfo mj_objectArrayWithKeyValuesArray:dic];
}

@end
