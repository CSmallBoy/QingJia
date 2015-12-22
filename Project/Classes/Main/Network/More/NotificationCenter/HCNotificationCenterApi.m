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

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
//    NSMutableArray *userArr = [NSMutableArray array];
//    for (NSInteger i = 0; i < 4; i ++)
//    {
//        HCNotificationCenterInfo *userInfo = [[HCNotificationCenterInfo alloc] init];
//      
//    }
    
    NSMutableArray *NotificationArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++)
    {
        HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc] init];
        info.userName = @"测试昵称";
        info.time = @"2015年10月20日 18:30";
        info.notificationMessage = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
        [NotificationArr addObject:info];
    }
    
   
    
    return NotificationArr;
}

@end
