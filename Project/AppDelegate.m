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

#import <AMapLocationKit/AMapLocationKit.h>

@interface AppDelegate ()<AMapLocationManagerDelegate>


@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置网络参数
    [self setupCustomProperty];
    // 环信
    [self setupEaseWithApplication:application Options:launchOptions];
    //版本更新
    [[HCVersionMgr manager] checkFirVersion];
    // 地图
    [self setupMAMap];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//设置主控制器
- (void)setupRootViewController
{
    [[HCAccountMgr manager] getLoginInfoData];
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
        _mainController = [[HCRootTabBarController alloc] init];
        
        HCLeftViewController *left = [[HCLeftViewController alloc] init];
        
        _homeNavController = _mainController.childViewControllers[0];
        
        _leftSlideController = [[LeftSlideViewController alloc] initWithLeftView:left andMainView:_mainController];
        
        self.window.rootViewController = _leftSlideController;
        
        HCHomeViewController *home = (HCHomeViewController *)_homeNavController.visibleViewController;
        if (!IsEmpty(_showWelcomeJoinGradeID))
        {
            home.gradeId = _showWelcomeJoinGradeID;
        }
    }
}

- (void)setupEaseWithApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions
{
    _connectionState = eEMConnectionConnected;
    
    // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
    [self parseApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    NSString *apnsCertName = EaseDeveloperApnsCertName;
#if DEBUG
    apnsCertName = EaseDeveloperApnsCertName;
#else
    apnsCertName = EaseApnsCerName;
#endif
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:EaseAppKey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController)
    {
        [self.mainController jumpToChatList];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController)
    {
        [self.mainController didReceiveLocalNotification:notification];
    }
}

- (void)setupCustomProperty
{
    //设置网络端口
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = kAPIURL;
    config.cdnUrl =  kIMGURL;
}

- (void)setupMAMap
{
    [AMapLocationServices sharedServices].apiKey = @"2068adf060e2dd5d56bc0626e6232c82";
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
    
    [self startUpdatingLocation];
    [self setupTimeLocation];
}

- (void)setupTimeLocation
{
     [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(startUpdatingLocation) userInfo:nil repeats:YES];
}

- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    DLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    DLog(@"%s, didUpdateLocation = {lat:%f; lon:%f;}", __func__, location.coordinate.latitude, location.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!IsEmpty(placemarks))
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            [HCAppMgr manager].address = placemark.name;
        }
    }];
    [HCAppMgr manager].latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    [HCAppMgr manager].longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    [self.locationManager stopUpdatingLocation];
}

@end
