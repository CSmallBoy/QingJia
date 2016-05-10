//
//  NHCSetNewPassWordApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCSetNewPassWordApi.h"

@implementation NHCSetNewPassWordApi
- (void)startRequest:(NHCNewPW)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //设置新密码
    return @"User/setNewPwd.do";
}
- (id)requestArgument
{
    NSDictionary *head = @{@"UUID":[readUserInfo GetUUID],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"userName":_PhoneNum};
    NSDictionary *para = @{@"userPWD":_NewPassWord};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
