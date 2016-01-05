//
//  HCPerfectMessageApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPerfectMessageApi.h"

@implementation HCPerfectMessageApi

- (void)startRequest:(HCPerfectMessageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/UserReg.ashx";
}

- (id)requestArgument
{
    NSString *address = [HCAppMgr manager].address;
    if (IsEmpty(address))
    {
        address = @"上海市闵行区";
    }
    NSDictionary *head = @{@"Action": @"REG", @"UserName": _UserName, @"Token": _Token, @"UUID": [HCAppMgr manager].uuid, @"Address": address, @"PlatForm": [HCAppMgr manager].systemVersion};
    
    NSDictionary *entity = @{@"TrueName": _TrueName, @"UserPWD": _UserPWD, @"Sex": _Sex, @"NickName": _UserName};
    NSDictionary *body = @{@"Head": head, @"Entity": entity};
    
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"];
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:dic[@"UserEntity"]];
    loginInfo.Token = dic[@"Token"];
    return loginInfo;
}


@end
