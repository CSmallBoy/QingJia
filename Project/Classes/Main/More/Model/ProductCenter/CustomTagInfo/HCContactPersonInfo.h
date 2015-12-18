//
//  HCContactPersonInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCContactPersonInfo : NSObject<NSMutableCopying>
/**
 *紧急联系人姓名
 */
@property (nonatomic,strong) NSString *contactName;
/**
 *关系
 */
@property (nonatomic,strong) NSString *contactRelationShip;
/**
 *紧急联系人姓名
 */
@property (nonatomic,strong) NSString *contactPhoneNum;
/**
 *紧急联系人身份证
 */
@property (nonatomic,strong) NSString *contactIDCard;

@end
