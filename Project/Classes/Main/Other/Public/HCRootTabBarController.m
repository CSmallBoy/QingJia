//
//  HCRootTabBarController.m
//  HealthCloud
//
//  Created by Vincent on 15/11/5.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRootTabBarController.h"
#import "WWSideslipViewController.h"

#import "HCHomeViewController.h"
#import "HCMessageViewController.h"
#import "HCMoreViewController.h"
#import "HCFoundViewController.h"

@interface HCRootTabBarController ()

@end

@implementation HCRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupChildControllers];
}

- (void)setupChildControllers
{
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_home"
                          rootViewControllerClass:[HCHomeViewController class]
                          rootViewControllerTitle:@"时光"];
//
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_found"
                          rootViewControllerClass:[HCFoundViewController class]
                          rootViewControllerTitle:@"消息"];
//
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_more"
                          rootViewControllerClass:[HCFoundViewController class]
                          rootViewControllerTitle:@"扫一扫"];

    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_me"
                          rootViewControllerClass:[HCMoreViewController class]
                          rootViewControllerTitle:@"更多"];
    
}

- (void)setSelIndex:(NSInteger)selIndex
{
    self.selectedIndex = selIndex;
}

- (void)setupChildNavigationControllerWithClass:(Class)class
                                tabBarImageName:(NSString *)name
                        rootViewControllerClass:(Class)rootViewControllerClass
                        rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = nil;
    if ([rootViewControllerClass isSubclassOfClass:[HCMoreViewController class]])
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WIDTH(self.view)*0.25, WIDTH(self.view)*0.3);
        CGFloat paddingY = 10;
        CGFloat paddingX = 20;
        layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
        layout.minimumLineSpacing = paddingY;
        rootVC = [[HCMoreViewController alloc] initWithCollectionViewLayout:layout];
    }else
    {
        rootVC = [[rootViewControllerClass alloc] init];
    }
    
    rootVC.title = title;
    
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = OrigIMG(name);
    
    NSString *selectedImage = [NSString stringWithFormat:@"%@_click",name];
    navVc.tabBarItem.selectedImage = OrigIMG(selectedImage);
    
    [self addChildViewController:navVc];
}

@end
