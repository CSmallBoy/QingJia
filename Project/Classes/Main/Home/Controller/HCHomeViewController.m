//
//  HCHomeViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHomeViewController.h"
#import "HCHomeFamilyViewController.h"
#import "HCHomeFamilyGroupViewController.h"
#import "HCPublishViewController.h"
//查询 家庭信息

#import "findFamilyMessage.h"
//城市三级联动
#import "HCGetCityInfoApi.h"
//设置tag
#import "HCSetTagMgr.h"

#import "AppDelegate.h"

@interface HCHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) HCHomeFamilyViewController *family;
@property (nonatomic, strong) HCHomeFamilyGroupViewController *familyGroup;

@end

@implementation HCHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    //self.mainScrollView.scrollEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.family.view];
    [self.mainScrollView addSubview:self.familyGroup.view];
    self.tabBarItem.badgeValue = @"3";
    //测试城市
//    HCGetCityInfoApi *api = [[HCGetCityInfoApi alloc]init];
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
//        
//    }];
    [[HCSetTagMgr manager]setPushTag];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    //家庭信息
    findFamilyMessage *api = [[findFamilyMessage alloc]init];
    NSDictionary *dic = [readUserInfo getReadDic];
    api.familyId = dic[@"UserInf"][@"createFamilyId"];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        NSString *str = respone[@"Data"][@"FamilyInf"][@"familyNickName"];
        if (_currentIndex == 0)
        {
            if (IsEmpty(str)) {
                self.title = @"时光";
            }else{
                self.navigationItem.title =[str stringByAppendingString:@"的时光"];
            }
        }else if(_currentIndex == 1)
        {
            self.title = @"XXXX的家族";
        }
    }];
   
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.x == 0)
    {
        [self handleLeftItem];
    }
}

#pragma mark - private methods


- (void)handleLeftItem
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (app.leftSlideController.closed)
    {
        [app.leftSlideController openLeftView];
    }
    else
    {
        [app.leftSlideController closeLeftView];
    }
}

- (void)handleRightItem
{
    HCPublishViewController *publish = [[HCPublishViewController alloc] init];
//    publish.data = @{@"data": self.dataSource};
    publish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)handleSegmentControl:(UISegmentedControl *)segment
{
    [self.mainScrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex * WIDTH(self.view), -64) animated:YES];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)leftItem
{
    if (!_leftItem)
    {
        _leftItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_left Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftItem)];
    }
    return _leftItem;
}

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_right Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView)
    {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-44)];
        //_mainScrollView.contentSize = CGSizeMake(WIDTH(self.view)*2, 0);
        _mainScrollView.contentSize = CGSizeMake(WIDTH(self.view), 0);
        _mainScrollView.backgroundColor = [UIColor greenColor];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (HCHomeFamilyViewController *)family
{
    if (!_family)
    {
        _family = [[HCHomeFamilyViewController alloc] init];
        _family.view.frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-108);
        _family.tabBarItem.title = @"1234444";
        [self addChildViewController:_family];
    }
    return _family;
}

- (HCHomeFamilyGroupViewController *)familyGroup
{
    if (!_familyGroup)
    {
        _familyGroup = [[HCHomeFamilyGroupViewController alloc] init];
        _familyGroup.view.frame = CGRectMake(WIDTH(self.view), 0, WIDTH(self.view), HEIGHT(self.view)-108);
        [self addChildViewController:_familyGroup];
    }
    return _familyGroup;
}

@end
