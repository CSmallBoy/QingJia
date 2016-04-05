//
//  HCCreateGradeInfo.h
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCreateGradeInfo : NSObject

@property (nonatomic, strong) NSString *familyId;
@property (nonatomic,strong) NSString *ancestralHome;//祖籍
@property (nonatomic, strong) NSString *familyNickName; // 家庭昵称
@property (nonatomic, strong) NSString *familyDescription; // 个性签名
@property (nonatomic, strong) NSString *familyPhoto; // 家庭头像
@property (nonatomic, strong) NSString *contactAddr;// 学校地址
@property (nonatomic, strong) UIImage *createTime; // 创建时间







@property (nonatomic, strong) UIImage *uploadImage;

@property (nonatomic, strong) NSString *OrderIndex;

@property (nonatomic, strong) NSString *VisitPassWord;

@property (nonatomic,strong) NSString *FamilyCode;

@property (nonatomic, strong) NSString *repassword;






@end
