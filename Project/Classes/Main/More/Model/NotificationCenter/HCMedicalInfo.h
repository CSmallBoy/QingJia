//
//  HCMedicalInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMedicalInfo : NSObject
/**
 *  身高
 */
@property (nonatomic,strong) NSString  *height;
/**
 *  体重
 */
@property (nonatomic,strong) NSString  *weight;
/**
 *  血型
 */
@property (nonatomic,strong) NSString  *bloodType;
/**
 *  医疗状况
 */
@property (nonatomic,strong) NSString  *medicalCondition;
/**
 *  医疗笔记
 */
@property (nonatomic,strong) NSString  *medicalNote;
/**
 *  过敏史
 */
@property (nonatomic,strong) NSString  *Allergy;
@end
