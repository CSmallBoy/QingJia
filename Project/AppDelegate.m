//
//  AppDelegate.m
//  Project
//
//  Created by 陈福杰 on 15/11/10.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "AppDelegate.h"
#import "HCAvatarMgr.h"
#import "HCVersionMgr.h"
#import "YTKNetworkConfig.h"
#import "HCHomeViewController.h"
#import "HCLoginViewController.h"
#import "HCLeftViewController.h"
#import "APService.h"

#import "AppDelegate+EaseMob.h"
#import "AppDelegate+Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置网络参数
    [self setupCustomProperty];
    // 环信
    [self setupEaseWithApplication:application Options:launchOptions];
    //设置主控制器
    //    [self setupRootViewController];
    //版本更新
    [[HCVersionMgr manager] checkFirVersion];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//设置主控制器
- (void)setupRootViewController
{
    //    if (![HCAppMgr manager].showInstroView)
    //    {
    //        DLog(@"加载欢迎页面,测试的取反");
    //    }
    if (![HCAccountMgr manager].isLogined)
    {
        HCLoginViewController *login = [[HCLoginViewController alloc]init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = loginNav;
    }else
    {
        [[HCAccountMgr manager] getLoginInfoData];
        
        HCRootTabBarController *main = [[HCRootTabBarController alloc] init];
        
        HCLeftViewController *left = [[HCLeftViewController alloc] init];
        UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:left];
        
        UINavigationController *nav = main.childViewControllers[0];
        UIView *homeView = nav.visibleViewController.view;
        
        _mainController=[[YRSideViewController alloc]init];
        _mainController.homeView = homeView;
        _mainController.rootViewController= main;
        _mainController.leftViewController=leftNav;
        _mainController.leftViewShowWidth= [UIScreen mainScreen].bounds.size.width*0.7;
        _mainController.needSwipeShowMenu=true;//默认开启的可滑动展示
        
        self.window.rootViewController = _mainController;
        
        HCHomeViewController *home = (HCHomeViewController *)nav.visibleViewController;
        if (!IsEmpty(_showWelcomeJoinGradeID))
        {
            home.gradeId = _showWelcomeJoinGradeID;
        }
    }
}

- (void)setupEaseWithApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions
{
    _connectionState = eEMConnectionConnected;
#warning 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:@"easemob-demo#chatdemoui"
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController)
    {
        HCRootTabBarController *rootTabBar = (HCRootTabBarController *)self.mainController.rootViewController;
        [rootTabBar jumpToChatList];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController)
    {
        HCRootTabBarController *rootTabBar = (HCRootTabBarController *)self.mainController.rootViewController;
        [rootTabBar didReceiveLocalNotification:notification];
    }
}

- (void)setupCustomProperty
{
    //设置网络端口
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = kAPIURL;
    config.cdnUrl =  kIMGURL;
}



@end
