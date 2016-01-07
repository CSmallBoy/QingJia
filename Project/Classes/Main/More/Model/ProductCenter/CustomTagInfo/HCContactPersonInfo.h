//
//  HCContactPersonInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCContactPersonInfo : NSObject


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
@property (nonatomic,strong) NSString *OrderIndex;
@end
