//
//  HCNotificationCenter.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCNotificationCenterBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCNotificationCenterApi : HCRequest

- (void)startRequest:(HCNotificationCenterBlock)requestBlock;

@property (nonatomic, assign) int NoticeType;
@property (nonatomic, strong) NSString *theStatus;

@property (nonatomic, assign) int Start;
@property (nonatomic, assign) int Count;

@end
