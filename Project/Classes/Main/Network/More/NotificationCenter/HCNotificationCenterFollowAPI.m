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

- (NSString *)requestUrl
{
    return @"Notice/Notice.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetDeepList" , @"Token":[HCAccountMgr manager].loginInfo.Token , @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"NoticeId": @(_NoticeId)};
    NSDictionary *result = @{@"Start" : @(_Start), @"Count" : @(_Count)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{

        HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc] init];
        info.SendUser = @"清海浮生";
        info.AddTime = @"2015年10月20日 18:30";
        info.NTitle = @"德玛西亚发布舒服https://baidu.com个必胜客当局包括世界杯赛捷克队比赛的";
    info.followInfoArr = @[@"已经跟进信息",@"已经跟进信息",
                           @"已经跟进信息",@"已经跟进信息",
                           @"已经跟进信息",@"已经跟进信息"];
    info.followTimeArr = @[@"2015年10月20日 18:30",@"2015年10月20日 18:30",
                           @"2015年10月20日 18:30",@"2015年10月20日 18:30",
                           @"2015年10月20日 18:30",@"2015年10月20日 18:30"];
    
       return info;
    return responseObject;//[@"Data"];

}



@end
