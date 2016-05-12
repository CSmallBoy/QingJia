//
//  HCNotificationViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.

// “应”界面 ————————————————————————————

#import "HCNotificationViewController.h"
#import "HCMyNotificationViewController.h"
#import "HCOtherNotificationViewController.h"
#import "HCNotificationHeadImageController.h"
#import "HCSaveNotificationViewController.h"
#import "HCMyPromisedDetailController.h"
#import "HCOtherPromisedDetailController.h"

@interface HCNotificationViewController ()

@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) HCMyNotificationViewController *myVC;
@property (nonatomic,strong) HCOtherNotificationViewController *otherVC;
@property (nonatomic,strong) HCSaveNotificationViewController *saveVC;

@end

@implementation HCNotificationViewController

- (void)viewDidLoad
{
    // “应”界面 ————————————————————————————
    [super viewDidLoad];

     [self setupBackItem];
     [self.view addSubview:self.segmented];
     [self.view addSubview:self.myVC.view];
     [self.view addSubview:self.otherVC.view];
     [self.view addSubview:self.saveVC.view];
      self.saveVC.view.hidden = YES;
      self.otherVC.view.hidden = YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark -----private method

- (void)ClickSegmentedControl:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        self.myVC.view.hidden = YES;
        self.saveVC.view.hidden = YES;
        self.otherVC.view.hidden = NO;
        [self.view endEditing:YES];
        
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        self.otherVC.view.hidden = YES;
        self.saveVC.view.hidden = YES;
        self.myVC.view.hidden = NO;
         [self.view endEditing:YES];
       

    }else
    {
        self.myVC.view.hidden = YES;
        self.otherVC.view.hidden = YES;
        self.saveVC.view.hidden = NO;
         [self.view endEditing:YES];
    }
}

#pragma mark----Setter Or Getter

-(UISegmentedControl *)segmented
{
        if (!_segmented)
        {
            _segmented = [[UISegmentedControl alloc] initWithItems:@[@"信息中心", @"与我相关",@"我的收藏"]];
            _segmented.selectedSegmentIndex = 1;
            _segmented.frame = CGRectMake(20, 74, SCREEN_WIDTH-40, 30);
            _segmented.backgroundColor = [UIColor whiteColor];
            [_segmented addTarget:self action:@selector(ClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
        }
        return _segmented;
}

-(HCMyNotificationViewController *)myVC
{
    if (!_myVC)
    {
        _myVC = [[HCMyNotificationViewController alloc]init];
        _myVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-50);
        _myVC.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:_myVC];
    }
    return _myVC;
}

-(HCOtherNotificationViewController *)otherVC
{
    if (!_otherVC)
    {
        _otherVC = [[HCOtherNotificationViewController alloc]init];
        _otherVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-50);
        [self addChildViewController:_otherVC];
    }
    return _otherVC;
}

-(HCSaveNotificationViewController *)saveVC
{
    if (!_saveVC)
    {
        _saveVC = [[HCSaveNotificationViewController alloc]init];
        _saveVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-50);
        [self addChildViewController:_saveVC];
    }
    return _saveVC;
}

@end
