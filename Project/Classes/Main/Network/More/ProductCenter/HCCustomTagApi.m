//
//  HCCustomTagApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagApi.h"
#import "HCTagUserInfo.h"

@implementation HCCustomTagApi


- (void)startRequest:(HCResumeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Shop/ObjectInf.ashx";
}


- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"Add", @"UUID": [HCAppMgr manager].uuid, @"Token": [HCAccountMgr manager].loginInfo.Token};
    
    NSDictionary *jsonDic = [_info mj_keyValues];

    NSDictionary *body = @{@"Head": head, @"Entity": jsonDic};
    return @{@"json": [Utils stringWithObject:body]};
    //    NSDictionary *dic = @{@"t": @"User,info", @"uid": [HCAccountMgr manager].loginInfo.Token, @"update": jsonDic};
    //    return dic;
    
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = nil;
    if (statusCode == HCRequestStatusFailure)
    {
        msg = @"加载失败";
    }
    return msg;
}

@end
