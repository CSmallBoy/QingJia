//
//  HCUserInfo.h
//  HealthCloud
//
//  Created by Vincent on 15/9/14.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCUserInfo : NSObject<NSMutableCopying>

@property (nonatomic, strong) NSString *wechat;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSMutableArray *album; // 图片的地址
@property (nonatomic, strong) NSMutableArray *albumurl;
@property (nonatomic, strong) NSString *educational;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *complete;

@property (nonatomic, strong) NSMutableArray *photoListArr; // 保存image
@property (nonatomic, strong) NSMutableArray *photoImageArr; // 保存全部的图片image

@property (nonatomic, strong) NSString *hometown;

@end
