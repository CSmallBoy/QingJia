//
//  HCNotificationCenterFollowAPI.h
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCNotificationCenterInfo;

typedef void(^HCNotificationCenterFollowBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);


@interface HCNotificationCenterFollowAPI : HCRequest

- (void)startRequest:(HCNotificationCenterFollowBlock)requestBlock;


@end
