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

- (NSString *)requestUrl
{
    return @"User/Login.ashx";
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"];
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:dic[@"UserInf"]];
    loginInfo.Token = dic[@"Token"];
    return loginInfo;
}
- (id)requestArgument
{
    NSDictionary *head = [Utils getRequestHeadWithAction:@"Login"];
    NSDictionary *para = @{@"UserName": _UserName, @"UserPWD": _UserPWD};
    NSDictionary *body = @{@"Head": head, @"Para": para};
    
    return @{@"json": [Utils stringWithObject:body]};
}




@end
