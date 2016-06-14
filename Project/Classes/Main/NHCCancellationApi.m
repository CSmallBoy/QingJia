//
//  NHCCancellationApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCCancellationApi.h"

@implementation NHCCancellationApi
- (void)startRequest:(NHCCancel)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //退出登录
    return @"User/logout.do";
}
- (id)requestArgument
{   //退出登录
    NSDictionary *dict  = [readUserInfo getReadDic];
    NSDictionary *head = nil;
    //添加判断防止退出时闪退
    if (!IsEmpty(dict))
    {
        head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                 @"platForm":[readUserInfo GetPlatForm],
                 @"userName":dict[@"UserInf"][@"userName"],
                 @"token":dict[@"Token"]};
    }
    else
    {
        head = @{};
    }
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    //退出时清理个人信息
//    [readUserInfo Dicdelete];
    return responseObject;
}
@end
