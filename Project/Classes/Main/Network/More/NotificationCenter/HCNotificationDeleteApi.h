//
//  HCNotificationDeleteApi.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCNotificationDeleteBlock)(HCRequestStatus requestStatus, NSString *message, id info);

@interface HCNotificationDeleteApi : HCRequest

- (void)startRequest:(HCNotificationDeleteBlock)requestBlock;

@property (nonatomic, assign) int NoticeId;

@end
