//
//  NHCBindPhoneNumAPi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCBindPhoneNumAPi.h"

@implementation NHCBindPhoneNumAPi
- (void)startRequest:(NHCUserInfo)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //验证验证码
    return @"User/addUserInfo.do";
}
- (id)requestArgument
{   //验证验证码
    NSDictionary *head = @{@"UUID":@"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"platForm":@"IOS9.3",@"token":@"Tu12-I52C-FV9A-8m32"};
    NSDictionary *para = @{@"newPhoneNo":@"18300701111",
                           @"theCode":@"验证码",                         
                           };
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
