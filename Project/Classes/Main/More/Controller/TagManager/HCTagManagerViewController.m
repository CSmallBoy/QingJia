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
#import "HCTagCloseTableViewController.h"
#import "HCCourseViewController.h"
#import "HCTagMangerMangerController.h"

#import "lhScanQCodeViewController.h"

@interface HCTagManagerViewController ()

@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) HCActivatedTableViewController *activatedTagVC;
@property (nonatomic,strong) HCTagCloseTableViewController *closedTagVC;

@property (nonatomic,strong) UIBarButtonItem *rightItem;

@property (nonatomic, assign)BOOL isPull;//是否弹出菜单
@property (nonatomic, strong)UIImageView *pullDownImage;//下拉菜单
//@property (nonatomic, strong)UITapGestureRecognizer *tag;

@end

@implementation HCTagManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"标签";
    [self setupBackItem];
    _isPull = NO;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.view addSubview:self.segmented];
    [self.view addSubview:self.activatedTagVC.view];
    [self.view addSubview:self.closedTagVC.view];
    [self.view addSubview:self.pullDownImage];
    self.closedTagVC.view.hidden = YES;
    
    //弹出拉下菜单
    UIBarButtonItem *right  = [[UIBarButtonItem alloc]initWithImage:IMG(@"导航条－inclass_Plus") style:UIBarButtonItemStylePlain target:self action:@selector(pullDownMenu)];
    self.navigationItem.rightBarButtonItem = right;
    
}

#pragma mark -----private methods

//点击+
- (void)pullDownMenu
{
    if (!_isPull)
    {
//        [self.navigationController.view addGestureRecognizer:self.tag];
        [UIView animateWithDuration:0.3 animations:^{
            self.pullDownImage.frame = CGRectMake(255/375.0*SCREEN_WIDTH, 64, 110/375.0*SCREEN_WIDTH, 82/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isPull = YES;
        }];
    }
    else
    {
//        [self.navigationController.view removeGestureRecognizer:self.tag];
        [UIView animateWithDuration:0.3 animations:^{
            self.pullDownImage.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -82/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 82/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isPull = NO;
        }];
    }
}

//点击扫码
- (void)scanButtonClick
{
    self.pullDownImage.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -82/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 82/668.0*SCREEN_HEIGHT);
    _isPull = NO;
    lhScanQCodeViewController *scanVC = [[lhScanQCodeViewController alloc]init];
    scanVC.isActive = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}

// 点击了管理按钮
-(void)manageBtnClick:(UIBarButtonItem *)right
{
    self.pullDownImage.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -82/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 82/668.0*SCREEN_HEIGHT);
    _isPull = NO;
    HCTagMangerMangerController *mangerVC = [[HCTagMangerMangerController alloc]init];
    [self.navigationController pushViewController:mangerVC animated:YES];
    
}

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
        self.closedTagVC.view.hidden = YES;
        self.activatedTagVC.view.hidden = NO;
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        
        
        self.activatedTagVC.view.hidden = YES;
        self.closedTagVC.view.hidden = NO;
   
    }
}

#pragma mark----Setter Or Getter

- (UIImageView *)pullDownImage
{
    if (_pullDownImage == nil)
    {
        UIButton *manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manageButton.frame = CGRectMake(20/375.0*SCREEN_WIDTH, 14/668.0*SCREEN_HEIGHT, 23/375.0*SCREEN_WIDTH, 23/668.0*SCREEN_HEIGHT);
        [manageButton setBackgroundImage:IMG(@"tag_manage") forState:UIControlStateNormal];
        [manageButton addTarget:self action:@selector(manageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *manageTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manageTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMinY(manageButton.frame), 67/375.0*SCREEN_WIDTH, CGRectGetHeight(manageButton.frame));
        [manageTitleButton setTitle:@"管理" forState:UIControlStateNormal];
        [manageTitleButton addTarget:self action:@selector(manageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanButton.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(manageButton.frame)+18/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), 14/668.0*SCREEN_HEIGHT);
        [scanButton setBackgroundImage:IMG(@"tag_scan") forState:UIControlStateNormal];
        [scanButton addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMinY(scanButton.frame) - 4, 67/375.0*SCREEN_WIDTH, CGRectGetHeight(manageTitleButton.frame));
        [scanTitleButton setTitle:@"扫码" forState:UIControlStateNormal];
        [scanTitleButton addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.pullDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(255/375.0*SCREEN_WIDTH, -82/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 82/668.0*SCREEN_HEIGHT)];
        self.pullDownImage.image = IMG(@"delete-report-23");
        self.pullDownImage.userInteractionEnabled = YES;

        
        [self.pullDownImage addSubview:manageButton];
        [self.pullDownImage addSubview:manageTitleButton];
        [self.pullDownImage addSubview:scanButton];
        [self.pullDownImage addSubview:scanTitleButton];
    }
    return _pullDownImage;
}

-(UISegmentedControl *)segmented
{
    if (!_segmented)
    {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[@"已激活",@"已停用"]];
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

-(HCTagCloseTableViewController *)closedTagVC
{
    if (!_closedTagVC)
    {
        _closedTagVC = [[HCTagCloseTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _closedTagVC.view.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self addChildViewController:_closedTagVC];
    }
    return _closedTagVC;
}


@end
