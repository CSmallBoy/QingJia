//
//  HCTagManagerInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCTagManagerInfo : NSObject
/**
 *标签使用者的姓名
 */
@property (nonatomic,strong) NSString *tagUserName;
/**
 *标签图
 */
@property (nonatomic,strong) NSArray *imgArr;
/**
 *标签名
 */
@property (nonatomic,strong) NSArray *tagNameArr;
/**
 *标签ID
 */
@property (nonatomic,strong) NSArray *tagIDArr;
/**
 *联系人头像
 */
@property (nonatomic,strong) NSArray *contactImgArr;
/**
 *联系人姓名
 */
@property (nonatomic,strong) NSArray *contactNameArr;
/**
 *联系人关系
 */
@property (nonatomic,strong) NSArray *contactRelationShipArr;
/**
 *联系人电话
 */
@property (nonatomic,strong) NSArray *contactPhoneArr;
/**
 *名片
 */
@property (nonatomic,strong) NSString *cardName;
/**
 *二维码图片
 */
@property (nonatomic,strong) NSString *cardImg;
/**
 *使用者性别
 */
@property (nonatomic,strong) NSString *userGender;
/**
 *使用者年龄
 */
@property (nonatomic,strong) NSString *userAge;
/**
 *使用者生日
 */
@property (nonatomic,strong) NSString *userBrithday;
/**
 *使用者地址
 */
@property (nonatomic,strong) NSString *userAddress;
/**
 *使用者学校
 */
@property (nonatomic,strong) NSString *userSchool;
/**
 *使用者职业
 */
@property (nonatomic,strong) NSString *userJob;
/**
 *使用者健康
 */
@property (nonatomic,strong) NSString *userHealth;

@property (nonatomic, assign) BOOL isShowRow;

@end
