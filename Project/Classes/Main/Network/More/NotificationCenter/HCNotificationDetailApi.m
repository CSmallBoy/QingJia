//
//  HCNotificationDetailApi.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNotificationDetailApi.h"
#import "HCNotificationDetailInfo.h"

@implementation HCNotificationDetailApi

- (void)startRequest:(HCNotificationDetailBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Notice/Notice.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"Get" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"NoticeId": @(_NoticeId)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    HCNotificationDetailInfo *info = [[HCNotificationDetailInfo alloc] init];
    info.SendUser = @"M-Talk";
    info.NTitle = @"测试消息[紧急通知]";
    info.NContent = @"测试内容,可放图片测试内容";
    info.AddTime = @"2015-08-18 23:08:52";
    info.Address = @"上海市闵行区莲花南路 1500 弄-5 号-101";
    info.AddressCode = @"31.102218,121.419388";
    return info;//[@"Data"];
    
}



@end
