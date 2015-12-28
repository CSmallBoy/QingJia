//
//  AppDelegate.h
//  Project
//
//  Created by 陈福杰 on 15/11/10.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSideViewController.h"
#import "HCRootTabBarController.h"
#import "ApplyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, IChatManagerDelegate>
{
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;

//设置主控制器
- (void)setupRootViewController;

@property (nonatomic, strong) NSString *showWelcomeJoinGradeID;

@property (strong,nonatomic) YRSideViewController *mainController;

@end

