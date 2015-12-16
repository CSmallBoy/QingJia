//
//  UIViewController+HCAOP.m
//  HealthCloud
//
//  Created by Vincent on 15/9/9.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "UIViewController+HCAOP.h"
#import <objc/runtime.h>
#import "YTKNetworkConfig.h"

@implementation UIViewController (HCAOP)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];    // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        //swizzleMethod(class, @selector(viewDidLoad), @selector(hc_viewDidLoad));
        //swizzleMethod(class, @selector(viewDidAppear:), @selector(hc_viewDidAppear:));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(hc_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(hc_viewWillDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(void)hc_viewWillAppear:(BOOL)animated {
    
    [self hc_viewWillAppear:animated];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)self;
//        nav.navigationBar.translucent = NO;
//        //nav.navigationBar.barTintColor = GLOBAL_NAVIGATION_BAR_TIN_COLOR;
//        nav.navigationBar.tintColor = [UIColor whiteColor];
//        NSDictionary *titleAtt = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//        [[UINavigationBar appearance] setTitleTextAttributes:titleAtt];
        [[UIBarButtonItem appearance]
         setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
         forBarMetrics:UIBarMetricsDefault];
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        //设置导航栏背景色
        [[UINavigationBar appearance] setBarTintColor:kHCNavBarColor];
        //设置导航栏文字图片背景颜色
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        //设置导航栏 文字颜色、字体大小
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:BOLDSYSTEMFONT(18.0)}];
        
        //[[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
        
        //tabBar 背景颜色
        UIImage *tabImg = [Utils createImageWithColor:UIColorFromRGB(0xf9f9f9)];
        [[UITabBar appearance] setBackgroundImage:tabImg];
        [[UITabBar appearance] setTintColor:kHCNavBarColor];
        
    }
    
//#ifndef DEBUG
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
//#endif
}

-(void)hc_viewWillDisappear:(BOOL)animated
{
    [self hc_viewWillDisappear:animated];
//#ifndef DEBUG
//    [MobClick endLogPageView:NSStringFromClass([self class])];
//#endif
}

//- (void)hc_viewDidLoad {
//    
//    [self hc_viewDidLoad];
//
//    //    self.view.backgroundColor = [UIColor whiteColor];self.navigationController.interactivePopGestureRecognizer.delegate = (id<uigesturerecognizerdelegate>)self;
//}

@end
