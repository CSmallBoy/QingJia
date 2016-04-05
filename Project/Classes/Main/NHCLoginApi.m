//
//  NHCLoginApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCLoginApi.h"

@implementation NHCLoginApi
- (void)startRequest:(NHCLogin)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{ //登陆
    return @"User/login.do";
}
- (id)requestArgument
{// 登陆
    
    
    NSDictionary *head = @{@"UUID":@"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"platForm":@"IOS9.3"};
    NSDictionary *para = @{@"userName":_UserName,@"userPWD":_UserPWD};
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"];
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:dic[@"UserInf"]];
    loginInfo.Token = dic[@"Token"];
    [readUserInfo Dicdelete];
    [readUserInfo creatDic:dic];
    return loginInfo;
}
@end
