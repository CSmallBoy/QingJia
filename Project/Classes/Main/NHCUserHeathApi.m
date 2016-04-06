//
//  NHCUserHeathApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCUserHeathApi.h"

@implementation NHCUserHeathApi

- (NSString *)requestUrl
{   //验证验证码
    return @"User/addUserInfo.do";
}
- (id)requestArgument
{   //验证验证码
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"height":@"18300701111",
                           @"weight":@"验证码",
                           @"bloodType":@"验证码",
                           @"allergic":@"验证码",
                           @"cureCondition":@"验证码",
                           @"cureNote":@"验证码"
                           };
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end


