//
//  HCNotificationCenter.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//  呼应信息中心模型

#import <Foundation/Foundation.h>

@interface HCNotificationCenterInfo : NSObject

@property (nonatomic,strong) NSString *isLoss;

@property (nonatomic,strong) NSString *callId;
@property (nonatomic,strong) NSString *lossTime;
@property (nonatomic,strong) NSString *lossAddress;
@property (nonatomic,strong) NSString *lossDesciption;
@property (nonatomic,strong) NSString *lossImageName;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *trueName;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *relation1;
@property (nonatomic,strong) NSString *contactorPhoneNo1;
@property (nonatomic,strong) NSString *relation2;
@property (nonatomic,strong) NSString *contactorPhoneNo2;

@end
