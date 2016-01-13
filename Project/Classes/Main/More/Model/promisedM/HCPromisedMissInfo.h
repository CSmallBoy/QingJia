//
//  HCPromisedMissInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCPromisedMissInfo : NSObject
/**
 *  走失地点
 */
@property(nonatomic,copy)NSString *LossAddress;
/**
 *  走失时间
 */
@property(nonatomic,copy)NSString *LossTime;
/**
 *  走失描述
 */
@property(nonatomic,copy)NSString  *LossDesciption;
/**
 *  id
 */
@property(nonatomic,assign)int  ObjectId;

@end
