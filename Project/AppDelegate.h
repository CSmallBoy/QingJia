//
//  AppDelegate.h
//  Project
//
//  Created by 陈福杰 on 15/11/10.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "HCRootTabBarController.h"
#import "ApplyViewController.h"

//极光推送key
static NSString *appKey = @"808316033bcbfb0f82a2e264";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
@interface AppDelegate : UIResponder <UIApplicationDelegate, IChatManagerDelegate>
{
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;


//设置主控制器
- (void)setupRootViewController;

@property (nonatomic, strong) NSString *showWelcomeJoinGradeID;
@property (nonatomic, strong) LeftSlideViewController *leftSlideController;
@property (strong, nonatomic) HCRootTabBarController *mainController;
@property (nonatomic, strong) UINavigationController *homeNavController;

@end

