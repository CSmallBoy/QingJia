//
//  HCNotificationCenterFollowAPI.h
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCNotificationCenterInfo;

typedef void(^HCNotificationCenterFollowBlock)(HCRequestStatus requestStatus, NSString *message, HCNotificationCenterInfo *info);


@interface HCNotificationCenterFollowAPI : HCRequest

- (void)startRequest:(HCNotificationCenterFollowBlock)requestBlock;
@property (nonatomic, assign) int NoticeId;
@property (nonatomic, strong) NSString *theStatus;

@property (nonatomic, assign) int Start;
@property (nonatomic, assign) int Count;
@end
