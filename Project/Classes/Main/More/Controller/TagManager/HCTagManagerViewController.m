//
//  HCTagManagerViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagManagerViewController.h"
#import "HCActivatedTableViewController.h"
#import "HCUnactivatedTagViewController.h"
#import "HCClosedTagViewController.h"
#import "HCCourseViewController.h"

@interface HCTagManagerViewController ()

@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) HCActivatedTableViewController *activatedTagVC;
@property (nonatomic,strong) HCUnactivatedTagViewController *unactivatedTagVC;
@property (nonatomic,strong) HCClosedTagViewController *closedTagVC;

@property (nonatomic,strong) UIBarButtonItem *rightItem;

@end

@implementation HCTagManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"标签管理";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.view addSubview:self.segmented];
    [self.view addSubview:self.activatedTagVC.view];
}

#pragma mark -----private methods

-(void)handleRightItem
{
    
    HCCourseViewController *courcesVC = [[HCCourseViewController alloc] init];
    UIViewController *rootController = self.view.window.rootViewController;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        courcesVC.modalPresentationStyle=
        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    }else
    {
        rootController.modalPresentationStyle=
        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    }
    courcesVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [rootController presentViewController:courcesVC animated:YES completion:nil];
    
}

- (void)handleSegmentedControl:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        self.navigationItem.rightBarButtonItem = nil;
        [self.unactivatedTagVC.view removeFromSuperview];
        [self.closedTagVC.view removeFromSuperview];
        [self.view addSubview:self.activatedTagVC.view];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        
        self.navigationItem.rightBarButtonItem = self.rightItem;
        [self.activatedTagVC.view removeFromSuperview];
        [self.closedTagVC.view removeFromSuperview];
        [self.view addSubview:self.unactivatedTagVC.view];
    }else if (segment.selectedSegmentIndex == 2)
    {
        self.navigationItem.rightBarButtonItem = nil;
        [self.activatedTagVC.view removeFromSuperview];
        [self.unactivatedTagVC.view removeFromSuperview];
        [self.view addSubview:self.closedTagVC.view];
    }
}

#pragma mark----Setter Or Getter

-(UISegmentedControl *)segmented
{
    if (!_segmented)
    {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[@"已激活", @"未激活",@"已停用"]];
        _segmented.selectedSegmentIndex = 0;
        _segmented.frame = CGRectMake(20, 74, SCREEN_WIDTH-40, 30);
        _segmented.backgroundColor = [UIColor whiteColor];
        _segmented.tintColor = [UIColor redColor];
        [_segmented addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}

-(HCActivatedTableViewController *)activatedTagVC
{
    if (!_activatedTagVC)
    {
        _activatedTagVC = [[HCActivatedTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _activatedTagVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self addChildViewController:_activatedTagVC];
    }
    return _activatedTagVC;
}

-(HCUnactivatedTagViewController *)unactivatedTagVC
{
    if (!_unactivatedTagVC)
    {
        _unactivatedTagVC = [[HCUnactivatedTagViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _unactivatedTagVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self addChildViewController:_unactivatedTagVC];
    }
    return _unactivatedTagVC;
}

-(HCClosedTagViewController *)closedTagVC
{
    if (!_closedTagVC)
    {
        _closedTagVC = [[HCClosedTagViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _closedTagVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self addChildViewController:_closedTagVC];
    }
    return _closedTagVC;
}

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
        _rightItem.title = @"教程";
        
    }
    return _rightItem;
}

@end
