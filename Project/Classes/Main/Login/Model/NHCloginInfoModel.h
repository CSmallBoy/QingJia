//
//  NHCloginInfoModel.h
//  Project
//
//  Created by 朱宗汉 on 16/3/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHCloginInfoModel : NSObject
@property (nonatomic, strong) NSString      *userId;
@property (nonatomic, strong) NSString      *status;
@property (nonatomic, strong) NSString      *userName;
@property (nonatomic, strong) NSString      *chatPwd;

@property (nonatomic, strong) NSString      *chatName;
@property (nonatomic, strong) NSString      *uuid;
@property (nonatomic, strong) NSString      *phoneNo;
@property (nonatomic, strong) NSString      *trueName;
@property (nonatomic, strong) NSString      *chineseZodiac;
@property (nonatomic, strong) NSString      *sex;
@property (nonatomic, strong) NSString      *birthDay;
@property (nonatomic, strong) NSString      *Token;
//@property (nonatomic, strong) NSString      *IsFMA;
//@property (nonatomic, strong) NSString      *DefaultFamilyID;
//@property (nonatomic, strong) NSString      *UserDescription;
//@property (nonatomic, strong) NSString      *UserPhoto;
@end
