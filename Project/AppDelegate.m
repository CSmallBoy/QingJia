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

#import "HCRootTabBarController.h"
#import "APService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置网络参数
    [self setupCustomProperty];
    //设置主控制器
    [self setupRootViewController];
    
    //版本更新
    [[HCVersionMgr manager] checkFirVersion];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//设置主控制器
- (void)setupRootViewController
{
    if ([HCAppMgr manager].showInstroView)
    {
//        self.window.rootViewController = [[HCWelcomViewController alloc]
    }else
    {
        [[HCAccountMgr manager] getLoginInfoData];
        self.window.rootViewController = [[HCRootTabBarController alloc] init];
    }
}

- (void)setupSelectedIndex:(NSInteger)index
{
    HCRootTabBarController *root = (HCRootTabBarController *)self.window.rootViewController;
    root.selIndex = index;
}

- (void)setupCustomProperty
{
    //设置网络端口
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = kAPIURL;
    config.cdnUrl =  kIMGURL;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end
