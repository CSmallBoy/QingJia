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
    self.title = @"加入班级";
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

- (IBAction)createGradeButton:(UIButton *)sender
{
    HCCreateGradeViewController *createGrade = [[HCCreateGradeViewController alloc] init];
    [self.navigationController pushViewController:createGrade animated:YES];
}

- (IBAction)joinGradeButton:(UIButton *)sender
{
    HCJoinGradeViewController *joinGrade = [[HCJoinGradeViewController alloc] init];
    [self.navigationController pushViewController:joinGrade animated:YES];
}

- (void)handleRightItem
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

@end
