//
//  NHCGetUserHeathApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCGetUserHeathApi.h"

@implementation NHCGetUserHeathApi


- (NSString *)requestUrl
{
    return @"User/getHealthCard.do";
}
- (id)requestArgument
{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"][@"healthCard"];
    NSString *str1 = dic[@"height"];
    NSString *str2 = dic[@"weight"];
    NSString *str3 = dic[@"bloodType"];
    NSString *Str4 = dic[@"allergic"];
    NSString *str5 = dic[@"cureCondition"];
    NSString *str6 = dic[@"cureNote"];
    NSArray *arr = @[str1,str2,str3,Str4,str5,str6];
    return arr;
}
@end