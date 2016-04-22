//
//  HCNotificationDetailInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNotificationDetailInfo : NSObject
/**
 *KeyId
 */
@property (nonatomic,strong) NSString *KeyId;
/**
 *SendUser
 */
@property (nonatomic,strong) NSString *SendUser;
/**
 *SysLevel
 */
@property (nonatomic,strong) NSString *SysLevel;
/**
 *NTitle
 */
@property (nonatomic,strong) NSString *NTitle;
/**
 *NContent
 */
@property (nonatomic,strong) NSString *NContent;
/**
 *AddTime
 */
@property (nonatomic,strong) NSString *AddTime;
/**
 *Address
 */
@property (nonatomic,strong) NSString *Address;
/**
 *AddressCode
 */
@property (nonatomic,strong) NSString *AddressCode;

// 新的接口模型字段



@end
