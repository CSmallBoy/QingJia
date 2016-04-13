//
//  HCNewTagInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface HCNewTagInfo : HCRequest

@property (nonatomic,strong) NSString *trueName; //姓名
@property (nonatomic,strong) NSString *imageName; // 图片
@property (nonatomic,strong) NSString *sex;  // 性别
@property (nonatomic,strong) NSString *birthDay; // 生日
@property (nonatomic,strong) NSString *homeAddress; // 家庭住址
@property (nonatomic,strong) NSString *school;   // 学校

@property (nonatomic,strong) NSString *height;   // 身高
@property (nonatomic,strong) NSString *weight;   // 体重
@property (nonatomic,strong) NSString *bloodType; //血型
@property (nonatomic,strong) NSString *allergic;  // 过敏史
@property (nonatomic,strong) NSString *cureCondition; // 医疗状况
@property (nonatomic,strong) NSString *cureNote;  // 医疗笔记

@end
