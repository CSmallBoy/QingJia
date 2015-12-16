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

//创建单例
+ (instancetype)manager;
//释放单利
+ (void)clean;

//登录
- (void)login;
//注销
- (void)logout;

@end
