//
//  HCNotificationCenter.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterApi.h"
#import "HCNotificationCenterInfo.h"
@implementation HCNotificationCenterApi

- (void)startRequest:(HCNotificationCenterBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Notice/Notice.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList" , @"Token":[HCAccountMgr manager].loginInfo.Token , @"UUID":[HCAccountMgr manager].loginInfo.UUID};

    NSDictionary *para = @{@"NociteType": @(_NoticeType), @"theStatus": _theStatus};
    NSDictionary *result = @{@"Start" : @(_Start), @"Count" : @(_Count)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}
@end
