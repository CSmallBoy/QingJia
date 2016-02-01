//
//  HCNotificationDeleteApi.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNotificationDeleteApi.h"

@implementation HCNotificationDeleteApi

- (void)startRequest:(HCNotificationDeleteBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Notice/Notice.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"Delete" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"NoticeId": @(_NoticeId)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
