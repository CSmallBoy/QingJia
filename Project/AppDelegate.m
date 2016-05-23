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
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "AppDelegate+EaseMob.h"
#import "AppDelegate+Parse.h"

#import <AMapLocationKit/AMapLocationKit.h>

#import "UMSocial.h"
#import "UMSocialSnsData.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "NHCCancellationApi.h"

#import "HCSetPushTagApi.h"

#import "HCGetCityInfoApi.h"
#import "HCGetCityInfoVersionApi.h"

@interface AppDelegate ()<AMapLocationManagerDelegate>


@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[HCAccountMgr manager] getLoginInfoData];
    //设置网络参数
    [self setupCustomProperty];
    // 环信
    [self setupEaseWithApplication:application Options:launchOptions];
    //版本更新
    [[HCVersionMgr manager] checkFirVersion];
    // 地图
    [self setupMAMap];
    
    [UMSocialData setAppKey:@"56971c14e0f55af6e5001da1"];
    
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    [UMSocialWechatHandler setWXAppId:@"wxa3e0f4e53bf74a06" appSecret:@"ed6ce4155f890517f746a2c1445dcb7e" url:@"http://www.umeng.com/social"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1105057631" appKey:@"fe72cpeF5yD0qWfO" url:@"http://www.umeng.com/social"];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    // 打开新浪微博的SSO开关,回调地址需与开放平台的回调地址一致
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1685716127"
                                         RedirectURL:@"http://sns.whalecloud.com/sina/callback"];
    
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]];
    
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // 极光设置tag
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiBack:) name:kJPFNetworkDidSetupNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiBack2:) name:kJPFNetworkDidCloseNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiBack3:) name:kJPFNetworkDidRegisterNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiBack4:) name:kJPFNetworkDidLoginNotification object:nil];
    
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(receiveCustomMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    //检测省市县三级联动数据版本
    [self getCityVersionFromService];
    
    return YES;
}


-(void)notiBack:(NSNotification *)noti
{
    NSLog(@" 建立连接  @@@@@@@@@@@@@@@@@ %@",noti.userInfo);
}

-(void)notiBack2:(NSNotification *)noti
{
    NSLog(@" 关闭连接 @@@@@@@@@@@@@@@@@ %@",noti.userInfo);
}
-(void)notiBack3:(NSNotification *)noti
{
    NSLog(@" 注册成功  @@@@@@@@@@@@@@@@@ %@",noti.userInfo[@"RegistrationID"]);
}
-(void)notiBack4:(NSNotification *)noti
{
    NSLog(@" 登陆成功  @@@@@@@@@@@@@@@@@ %@",noti.userInfo); 
    //设置tags
    NSSet *tags = [NSSet setWithObject:@"22222"];
    NSSet *set = [JPUSHService filterValidTags:tags];
    
    [JPUSHService setTags:set alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);

    }];
}

//-(void)tagsAliasCallback:(int)iResCode
//                    tags:(NSSet*)tags
//                   alias:(NSString*)alias
//{
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
//}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        return YES;
    }
    return result;
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}


//设置主控制器
- (void)setupRootViewController
{
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

//获取极光自定义消息
- (void)receiveCustomMessage:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];//内容
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"];
    
    NSLog(@"customMessage: %@",userInfo);
}

//极光服务器的推送消息类型
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@", userInfo);
    if (_mainController)
    {
        [self.mainController jumpToChatList];
    }
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"time" object:nil userInfo:userInfo];
}
// log NSSet with UTF8
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

//接受本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController)
    {
        [self.mainController didReceiveLocalNotification:notification];
    }
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)setupCustomProperty
{
    //设置网络端口
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = kAPIURL;
    //config.cdnUrl =  kIMGURL;
}

- (void)setupMAMap
{
    [AMapLocationServices sharedServices].apiKey = @"20e897d0e7d653770541a040a12065d8";
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
    
    [self startUpdatingLocation];
//    [self setupTimeLocation];
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
    [HCAppMgr manager].address = [NSString stringWithFormat:@"%@,%@,%@,%@",@"上海",@"上海市",@"闵行区",@"集心路37号"];
    [HCAppMgr manager].addressSmall = @"上海市,闵行区";
    [HCAppMgr manager].latitude = @"31.232";
    [HCAppMgr manager].longitude = @"37.2242";
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!IsEmpty(placemarks))
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            [HCAppMgr manager].address = [NSString stringWithFormat:@"%@,%@,%@,%@",placemark.administrativeArea,placemark.locality,placemark.thoroughfare,placemark.subThoroughfare];
            [HCAppMgr manager].addressSmall = placemark.locality;
        }
    }];
    
    [self.locationManager stopUpdatingLocation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showRadarView" object:nil];
}

#pragma mark - GetAllArea
//获取全国省市县三级数据
- (void)getAllCityInfoFromService
{
    HCGetCityInfoApi *api = [[HCGetCityInfoApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"];
            [self writeCityInfoToPlist:dic];
        }
    }];
}

//将数据保存到plist文件中
- (void)writeCityInfoToPlist:(NSDictionary *)dic
{
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path =[paths objectAtIndex:0];
    NSString *cityList =[path stringByAppendingPathComponent:@"city.plist"];
    [dic writeToFile:cityList atomically:YES];
    NSLog(@"**** %@", cityList);
}

//获取省市县三级联动数据版本号
- (void)getCityVersionFromService
{
    HCGetCityInfoVersionApi *api = [[HCGetCityInfoVersionApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone)
    {
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSString *versionStr = [respone[@"Data"] objectForKey:@"version"];
            //第一次启动
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"First_Start"])
            {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"First_Start"];
                [[NSUserDefaults standardUserDefaults] setInteger:[versionStr integerValue] forKey:@"City_Version"];
                [self getAllCityInfoFromService];
            }
            else
            {
                NSInteger oldVersion = [[NSUserDefaults standardUserDefaults] integerForKey:@"City_Version"];
                if ([versionStr integerValue] > oldVersion)
                {
                    [self getAllCityInfoFromService];
                }
            }
        }
    }];
}


@end
