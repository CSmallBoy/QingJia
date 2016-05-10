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
#import "HCGradeManagerViewController.h"
#import "HCJoinGradeViewController.h"
#import "MyFamilyViewController.h"
#import "HCCreateGradeViewController.h"
#import "HCLeftView.h"
#import "HCLeftGradeView.h"

#import "HCUserMessageViewController.h"

@interface HCLeftViewController ()<HCLeftViewDelegate, HCLeftGradeViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HCLeftView *leftView;
@property (nonatomic, strong) HCLeftGradeView *leftGradeView;

@end

@implementation HCLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toCreateFamilyVC) name:@"toCreateFamilyVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toJoinFamilyVC) name:@"toJoinFamilyVC" object:nil];
    
    
    self.view.backgroundColor = RGB(34, 35, 37);
//    [self.view addSubview:self.leftView];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.leftGradeView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    }
    [self pushViewController:vc];
}

#pragma mark - HCLeftGradeViewDelegate

- (void)hcleftGradeViewSelectedButtonType:(HCLeftGradeViewButtonType)type
{
    HCViewController *vc = nil;
    if (type == HCLeftGradeViewButtonTypeGradeButton)
    {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(WIDTH(self.view)*0.18, WIDTH(self.view)*0.23);
//        CGFloat paddingY = 10;
//        CGFloat paddingX = 20;
//        layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
//        layout.minimumInteritemSpacing = paddingY;
        
//        vc = (HCViewController *)[[HCGradeManagerViewController alloc] initWithCollectionViewLayout:layout];
        
        NSString *str = [HCAccountMgr manager].loginInfo.createFamilyId;
         NSString *strFamilyId = [readUserInfo getFaimilyDic][@"familyId"];
        NSString *frist = [str substringToIndex:1];
        if ((IsEmpty(str) || [str isKindOfClass:[NSNull class]])&& IsEmpty(strFamilyId))
        {
           
            vc = [[HCUserMessageViewController alloc]init];
            
        }else
        {
            if ([frist isEqualToString:@"F"])
            {
            
                vc = [[HCGradeManagerViewController alloc] init];
            
            }else
            {
                vc = [[HCUserMessageViewController alloc]init];
            
            }
        
        }

    }else if (type == HCLeftGradeViewButtonTypeHead)
    {
        vc  = [[HCUserMessageViewController alloc] init];
    }else if (type == HCLeftGradeViewButtonTypeSoftwareSet)
    {
        vc = [[HCSoftwareSettingViewController alloc] init];
    }else if (type == HCLeftGradeViewFamily)
    {
        vc = [[MyFamilyViewController alloc] init];
    }
    
    [self pushViewController:vc];
}

#pragma mark - private methods

- (void)pushViewController:(HCViewController *)vc
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    vc.hidesBottomBarWhenPushed = YES;
    [app.leftSlideController closeLeftView];
    [app.homeNavController pushViewController:vc animated:YES];
}


-(void)toCreateFamilyVC
{
    HCCreateGradeViewController *createFamilyVC = [[HCCreateGradeViewController alloc]init];
    [self pushViewController:createFamilyVC];
}

-(void)toJoinFamilyVC
{
    HCJoinGradeViewController *JoinFamilyVC = [[HCJoinGradeViewController alloc]init];
    [self pushViewController:JoinFamilyVC];

}

#pragma mark - setter or getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HCLeftView *)leftView
{
    if (!_leftView)
    {
        _leftView = [[HCLeftView alloc] initWithFrame:self.view.frame];
        _leftView.delegate = self;
    }
    return _leftView;
}

- (HCLeftGradeView *)leftGradeView
{
    if (!_leftGradeView)
    {
        _leftGradeView = [[HCLeftGradeView alloc] initWithFrame:self.view.frame];
        _leftGradeView.delegate = self;

        
    }
    return _leftGradeView;
}



@end
