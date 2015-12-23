//
//  HCLeftViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCLeftViewController.h"
#import "AppDelegate.h"
#import "HCSoftwareSettingViewController.h"
#import "HCUserMessageViewController.h"
#import "HCLeftView.h"

@interface HCLeftViewController ()<HCLeftViewDelegate>

@property (nonatomic, strong) HCLeftView *leftView;

@end

@implementation HCLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(34, 35, 37);
    [self.view addSubview:self.leftView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.sideViewController showHomeView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.sideViewController hideHomeView];
}

#pragma mark - HCLeftViewDelegate

- (void)hcleftViewSelectedButtonType:(HCLeftViewButtonType)type
{
    HCViewController *vc = nil;
    if (type == HCLeftViewButtonTypeHead)
    {
        vc  = [[HCUserMessageViewController alloc] init];
    }else if (type == HCLeftViewButtonTypeCreateGrade)
    {
        DLog(@"创建班级");
    }else if (type == HCLeftViewButtonTypeJoinGrade)
    {
        DLog(@"加入班级");
    }else if (type == HCLeftViewButtonTypeSoftwareSet)
    {
        vc = [[HCSoftwareSettingViewController alloc] init];
    }
    
    UIViewController *control = self.view.window.rootViewController.childViewControllers[0];
    vc.hidesBottomBarWhenPushed = YES;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.sideViewController hideSideViewController:YES];
    UINavigationController *nav = control.childViewControllers[0];
    [nav.visibleViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter or getter

- (HCLeftView *)leftView
{
    if (!_leftView)
    {
        _leftView = [[HCLeftView alloc] initWithFrame:self.view.frame];
        _leftView.delegate = self;
    }
    return _leftView;
}


@end
