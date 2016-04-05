//
//  NHCCancellationApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCCancellationApi.h"

@implementation NHCCancellationApi
- (void)startRequest:(NHCCancel)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //验证验证码
    return @"User/logout.do";
}
- (id)requestArgument
{   //验证验证码
    NSDictionary *head = @{@"UUID":@"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"platForm":@"IOS9.3",@"userName":@"18300701234",@"token":@"680A-68jo-P657-Z8n6"};
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
