//
//  NHCRegisteredApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCRegisteredApi.h"

@implementation NHCRegisteredApi
- (void)startRequest:(HCRegister)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{ //注册
    return @"User/regUser.do";
}
- (id)requestArgument
{// 注册
    NSDictionary *head = @{@"UUID":[readUserInfo GetUUID],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"userName":_userName,
                           @"address":@"上海市"};
    NSDictionary *para = @{@"trueName":_TrueName,
                           @"birthDay":_birthday,
                           @"userPWD":_passWord,
                           @"sex":_sex};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"];
    HCLoginInfo *loginfo = [HCLoginInfo mj_objectWithKeyValues:dic[@"UserEntity"]];
    loginfo.Token = dic[@"Token"];
    return responseObject;
}
@end
