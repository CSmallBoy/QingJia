//
//  HCNotificationCenter.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNotificationCenterInfo : NSObject
/**
 *姓名
 */
@property (nonatomic,strong) NSString *userName;

/**
 *时间
 */
@property (nonatomic,strong) NSString *time;

/**
 *具体通知信息
 */
@property (nonatomic,strong) NSString *notificationMessage;
@end
