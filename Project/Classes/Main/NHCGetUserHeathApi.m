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
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *str5;
    NSString *str6;
    NSArray *arr ;
    if (IsEmpty(responseObject[@"Data"][@"healthCard"])) {
        arr =  nil;
    }else{
        NSDictionary *dic = responseObject[@"Data"][@"healthCard"];
        str1 = dic[@"height"];
        str2 = dic[@"weight"];
        str3 = dic[@"bloodType"];
        str4 = dic[@"allergic"];
        str5 = dic[@"cureCondition"];
        str6 = dic[@"cureNote"];
      arr = @[str1,str2,str3,str4,str5,str6];
        
    }
   return arr;
}
@end