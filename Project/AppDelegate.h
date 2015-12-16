//
//  AppDelegate.h
//  Project
//
//  Created by 陈福杰 on 15/11/10.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//设置主控制器
- (void)setupRootViewController;

// 选择下面按钮
- (void)setupSelectedIndex:(NSInteger)index;


@end

