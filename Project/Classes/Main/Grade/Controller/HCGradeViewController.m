//
//  HCGradeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeViewController.h"
#import "HCCreateGradeViewController.h"
#import "HCJoinGradeViewController.h"
#import "HCHomeViewController.h"
#import "AppDelegate.h"

@interface HCGradeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *createGrade;
@property (weak, nonatomic) IBOutlet UIButton *joinGrade;
@property (nonatomic, strong) UIBarButtonItem *rightItem;


@end

@implementation HCGradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    [self.createGrade setTitle:@"创建家庭" forState:UIControlStateNormal];
    [self.joinGrade setTitle:@"加入家庭" forState:UIControlStateNormal];
    self.title = @"加入家庭";
    ViewRadius(_createGrade, 4);
    ViewRadius(_joinGrade, 4);
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[Utils createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[Utils createImageWithColor:kHCNavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault   ;
}

#pragma mark - private methods
//创建 家庭
- (IBAction)createGradeButton:(UIButton *)sender
{
    HCCreateGradeViewController *createGrade = [[HCCreateGradeViewController alloc] init];
    [self.navigationController pushViewController:createGrade animated:YES];
}
//加入 家庭
- (IBAction)joinGradeButton:(UIButton *)sender
{
    HCJoinGradeViewController *joinGrade = [[HCJoinGradeViewController alloc] init];
    [self.navigationController pushViewController:joinGrade animated:YES];
}

- (void)handleRightItem1
{

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
    
  
    
}

#pragma mark - setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem1)];
    }
    return _rightItem;
}

@end
