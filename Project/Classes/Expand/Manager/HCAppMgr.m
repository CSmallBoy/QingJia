//
//  HCAppMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/15.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAppMgr.h"
#import "AppDelegate.h"
#import "HCLogoutApi.h"
#import "HCAccountDBMgr.h"
#import "UIAlertView+HTBlock.h"
#import "HCGetUserInfoByDeviceApi.h"
//退出
#import "NHCCancellationApi.h"
static HCAppMgr *_sharedManager = nil;

@implementation HCAppMgr

//创建单例

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAppMgr alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init])
    {
        //token失效
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginTokenInvalided)
                                                     name:kHCAccessTokenExpiredNotification
                                                   object:nil];
        //下线通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(accountKickedOffTheLine)
//                                                     name:kHCNotificationOffline
//                                                   object:nil];
    }
    return self;
}

+ (void)clean
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _sharedManager = nil;
}

#pragma mark - Setters & Getters

- (NSString *)uuid
{
    if (!_uuid)
    {
        _uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    }
    return _uuid;
}

- (NSString *)systemVersion
{
    if (!_systemVersion)
    {
        _systemVersion = [NSString stringWithFormat:@"IOS%@", [Utils getDeviceVersion]];
    }
    return _systemVersion;
}

// 是否首次启动程序，启动加载页

- (BOOL)showInstroView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long long flag = [[defaults objectForKey:@"GUIDE"] longLongValue];
    
    if (flag == 0) //首次运行，加载引导页
    {
        [defaults setObject:@(++flag) forKey:@"GUIDE"];
        [defaults synchronize];
        
        return YES;
    }
    return NO;
}

#pragma mark - Public Methods

//登录

- (void)login
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
}

//注销

- (void)logout
{
    [self requestLogout];
    
    [[HCAccountMgr manager] clean];
}

// token失效，提醒用户重新登录

- (void)loginTokenInvalided
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您的登录会话已失效，请重新登录。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];

    
    [alert handlerClickedButton:^(UIAlertView *alert, NSInteger index){
        // 环信登出
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (error && error.errorCode != EMErrorServerNotLogin) {
            }
            else
            {
                [[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        } onQueue:nil];
        //清空数据，返回登录
        [[HCAccountMgr manager] clean];
        [HCAccountMgr manager].isLogined = NO;
        [self login];
    }];
    
    [alert show];
}

// 退出

- (void)requestLogout
{
    NHCCancellationApi *api2 = [[NHCCancellationApi alloc]init];
    [api2 startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self login];
    }];
    [HCAccountMgr manager].isLogined = NO;
    //环信账号退出
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (error && error.errorCode != EMErrorServerNotLogin) {
        }
        else
        {
            [[ApplyViewController shareController] clear];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
    } onQueue:nil];
}


@end
