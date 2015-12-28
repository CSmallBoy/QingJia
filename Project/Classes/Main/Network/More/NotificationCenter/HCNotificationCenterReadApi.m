//
//  HCNotificationCenterReadApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterReadApi.h"
#import "HCNotificationCenterInfo.h"

@implementation HCNotificationCenterReadApi

- (void)startRequest:(HCNotificationCenterReadBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
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
}


@end
