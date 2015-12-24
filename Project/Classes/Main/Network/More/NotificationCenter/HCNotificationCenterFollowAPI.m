//
//  HCNotificationCenterFollowAPI.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterFollowAPI.h"
#import "HCNotificationCenterInfo.h"

@implementation HCNotificationCenterFollowAPI

- (void)startRequest:(HCNotificationCenterFollowBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
//    NSMutableArray *NotificationArr = [NSMutableArray array];
//    for (NSInteger i = 0; i < 5; i++)
//    {
        HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc] init];
        info.userName = @"清海浮生";
        info.time = @"2015年10月20日 18:30";
        info.notificationMessage = @"德玛西亚发布舒服https://baidu.com个必胜客当局包括世界杯赛捷克队比赛的";
//        [NotificationArr addObject:info];
//    }
    
    
    
    return info;
}



@end
