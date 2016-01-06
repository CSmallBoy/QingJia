//
//  HCNotificationDetailApi.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCNotificationDetailInfo;

typedef void(^HCNotificationDetailBlock)(HCRequestStatus requestStatus, NSString *message, HCNotificationDetailInfo *info);

@interface HCNotificationDetailApi : HCRequest

- (void)startRequest:(HCNotificationDetailBlock)requestBlock;

@property (nonatomic, assign) int NoticeId;

@end
