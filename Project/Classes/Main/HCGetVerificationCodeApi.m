//
//  HCGetVerificationCodeApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCGetVerificationCodeApi.h"

@implementation HCGetVerificationCodeApi
- (void)startRequest:(HCGetCode)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{ //获取验证码
    return @"User/getAuthCode.do"; 
}
- (id)requestArgument
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSDictionary *head = @{@"platForm": @"IOS9.3", @"UUID": @"3284F4E0-80CE-4F14-AEA8-1361066BFBBB"};
    NSDictionary *para = @{@"phoneNumber": _phoneNumber, @"theType": _thetype};
    return @{@"Head": head, @"Para": para};
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
