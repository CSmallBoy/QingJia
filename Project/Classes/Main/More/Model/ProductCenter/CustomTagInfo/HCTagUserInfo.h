//
//  HCTagUserInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HCTagUserInfo : NSObject<NSMutableCopying>

///**
// *使用者头像
// */
//@property (nonatomic,strong) NSString *userImageStr;
///**
// *使用者头像
// */
//@property (nonatomic,strong) NSString *userImageUrlStr;
//
///**
// *使用者姓名
// */
//@property (nonatomic,strong) NSString *userName;
///**
// *使用者性别
// */
//@property (nonatomic,strong) NSString *userGender;
///**
// *使用者生日
// */
//@property (nonatomic,strong) NSString *userBirthday;
///**
// *使用者地址
// */
//@property (nonatomic,strong) NSString *userAddress;
///**
// *使用者学校
// */
//@property (nonatomic,strong) NSString *userSchool;
///**
// *使用者学校
// */
//@property (nonatomic,strong) NSString *userPhoneNum;
///**
// *使用者身份证
// */
//@property (nonatomic,strong) NSString *userIDCard;
///**
// *紧急联系人
// */
//@property (nonatomic,strong) NSMutableArray *contactInfoArr;
//
///**
// *使用者血型
// */
//@property (nonatomic,strong) NSString *userBloodType;
///**
// *使用者过敏史
// */
//@property (nonatomic,strong) NSString *userAllergicHistory;



/**
 *姓名
 */
@property (nonatomic,strong) NSString *ObjectXName;
/**
 *性别
 */
@property (nonatomic,strong) NSString *ObjectSex;
/**
 *生日
 */
@property (nonatomic,strong) NSString *ObjectBirthDay;
/**
 *地址
 */
@property (nonatomic,strong)  NSString *ObjectHomeAddress;
/**
 *学校
 */
@property (nonatomic,strong)  NSString *ObjectSchool;
/**
 *身份证号
 */
@property (nonatomic,strong) NSString *ObjectIdNo;
/**
 *职业
 */
@property (nonatomic,strong)  NSString *ObjectCareer;
/**
 *血型
 */
@property (nonatomic,strong)  NSString *BloodType;
/**
 *过敏史
 */
@property (nonatomic,strong) NSString *Allergic;
/**
 *联系人
 */
@property (nonatomic,strong) NSMutableArray *ContactArray;
@end
