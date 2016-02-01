//
//  HCNotificationUnreadChangeApi.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCNotificationUnreadChangeBlock)(HCRequestStatus requestStatus, NSString *message, id info);

@interface HCNotificationUnreadChangeApi : HCRequest

- (void)startRequest:(HCNotificationUnreadChangeBlock)requestBlock;

@property (nonatomic, assign) int NoticeId;

@end
