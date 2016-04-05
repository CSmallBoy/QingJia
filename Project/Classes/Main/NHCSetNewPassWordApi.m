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
{   //验证验证码
    return @"User/setNewPwd.do";
}
- (id)requestArgument
{   //验证验证码
    NSDictionary *head = @{@"UUID":@"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"platForm":@"IOS9.3",@"userName":_PhoneNum};
    NSDictionary *para = @{@"userPWD":_NewPassWord};
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
