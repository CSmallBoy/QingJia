//
//  HCPromisedDetailInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCPromisedDetailInfo : NSObject
/**
 *   姓名
 */
@property(nonatomic,copy)NSString * name;
/**
 *  性别
 */
@property(nonatomic,copy)NSString * sex;
/**
 *  年龄
 */
@property(nonatomic,copy)NSString * age;
/**
 *  地址
 */
@property(nonatomic,copy)NSString * address;
/**
 *  学校
 */
@property(nonatomic,copy)NSString * scroll;
/**
 *  紧急联系人1姓名
 */
@property(nonatomic,copy)NSString * callName1;
/**
 *  紧急联系人2姓名
 */
@property(nonatomic,copy)NSString * callName2;
/**
 *  联系人1关系
 */
@property(nonatomic,copy)NSString * relationship1;
/**
 *  联系人2关系
 */
@property(nonatomic,copy)NSString * relationship2;
/**
 *  联系人1电话
 */
@property(nonatomic,copy)NSString * callTel1;
/**
 *  联系人2电话
 */
@property(nonatomic,copy)NSString * callTel2;
/**
 *  走失地址
 */
@property(nonatomic,copy)NSString * missAddress;
/**
 *  描述
 */
@property(nonatomic,copy)NSString * describtion;
/**
 *  血型
 */
@property(nonatomic,copy)NSString * bloodType;
/**
 *  过敏史
 */
@property(nonatomic,copy)NSString * allergy;


@end
