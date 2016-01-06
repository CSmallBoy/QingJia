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
    NSDictionary *head = @{@"Action" : @"GetList" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};

    NSDictionary *para = @{@"NoticeType": @(_NoticeType), @"theStatus": _theStatus};
    NSDictionary *result = @{@"Start" : @(_Start), @"Count" : @(_Count)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *NotificationArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 11; i++)
    {
        HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc] init];
        info.userName = @"哈哈昵称";
        info.time = @"2015年10月20日 18:30";
        info.notificationMessage = @"啦啦啦德玛西亚文化分别将发布舒服https://baidu.com个必胜客当局包括世界杯赛捷克队比赛的";
        [NotificationArr addObject:info];
    }
    return NotificationArr;
    return responseObject[@"Data"];
}
@end
