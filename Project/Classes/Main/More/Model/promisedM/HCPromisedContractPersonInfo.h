//
//  HCPromisedContractPersonInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCPromisedContractPersonInfo : NSObject
/**
 *姓名
 */
@property (nonatomic,strong) NSString *ObjectXName;
/**
 *关系
 */
@property (nonatomic,strong) NSString *ObjectXRelative;
/**
 *手机号
 */
@property (nonatomic,strong)  NSString *PhoneNo;
/**
 *身份证号
 */
@property (nonatomic,strong)  NSString *IDNo;
/**
 *联系人号
 */
@property (nonatomic,strong) NSNumber *  OrderIndex;

@end
