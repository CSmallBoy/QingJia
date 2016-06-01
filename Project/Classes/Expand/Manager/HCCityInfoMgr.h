//
//  HCCityInfoMgr.h
//  钦家
//
//  Created by Tony on 16/5/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCityInfoMgr : NSObject
/**
 *  省市县三级联动数据解析类
 *
 */
+ (HCCityInfoMgr *)manager;
/**
 *  取出省市县三级数据
 */
- (NSMutableDictionary *)getAllProvinces;

@end
