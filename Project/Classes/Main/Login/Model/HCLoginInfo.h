//
//  HCLoginInfo.h
//  HealthCloud
//
//  Created by Vincent on 15/9/22.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCLoginInfo : NSObject

@property (nonatomic, strong) NSString      *UserId;
@property (nonatomic, strong) NSString      *HomeAddress;
@property (nonatomic, strong) NSString      *Company;
@property (nonatomic, strong) NSString      *Career;

@property (nonatomic, strong) NSString      *Token;
@property (nonatomic, strong) NSString      *UUID;
@property (nonatomic, strong) NSString      *PhoneNo;
@property (nonatomic, strong) NSString      *UserName;
@property (nonatomic, strong) NSString      *TrueName;
@property (nonatomic, strong) NSString      *NickName;
@property (nonatomic, strong) NSString      *Sex;
@property (nonatomic, strong) NSString      *Age;
@property (nonatomic, strong) NSString      *IsFMA;
@property (nonatomic, strong) NSString      *DefaultFamilyID;
@property (nonatomic, strong) NSString      *UserDescription;
@property (nonatomic, strong) NSString      *UserPhoto;


@end
