//
//  HCAppMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/15.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCAppMgr : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) NSString *deviceToken;

//是否显示引导页
@property (nonatomic, assign) BOOL showInstroView;

// 地址信息
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *addressSmall;
@property (nonatomic, strong) NSString *latitude; // 纬度
@property (nonatomic, strong) NSString *longitude; // 经度

// Device
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *systemVersion;


//创建单例
+ (instancetype)manager;
//释放单利
+ (void)clean;

//登录
- (void)login;
//注销
- (void)logout;

@end
