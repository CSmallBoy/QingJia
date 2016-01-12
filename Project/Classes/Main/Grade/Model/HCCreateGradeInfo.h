//
//  HCCreateGradeInfo.h
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCreateGradeInfo : NSObject

@property (nonatomic, strong) NSString *KeyId;

@property (nonatomic, strong) NSString *FamilyMainAccountID;

@property (nonatomic, strong) NSString *FamilyCode;

@property (nonatomic, strong) NSString *FamilyName;

@property (nonatomic, strong) NSString *FamilyNickName; // 个性签名

@property (nonatomic, strong) NSString *FamilyPhoto;

@property (nonatomic, strong) UIImage *uploadImage;

@property (nonatomic, strong) NSString *OrderIndex;

@property (nonatomic, strong) NSString *VisitPassWord;

@property (nonatomic, strong) NSString *ContactAddr;

@property (nonatomic, strong) NSString *repassword;

@property (nonatomic, strong) UIImage *CreateTime;

@end
