//
//  HCHomeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeFamilyViewController.h"
#import "HCHomeDetailViewController.h"
#import "HCShareViewController.h"
#import "HCHomeUserTimeViewController.h"
#import "HCEditCommentViewController.h"
#import "HCHomePictureDetailViewController.h"
#import "MJRefresh.h"
#import "HCWelcomeJoinGradeViewController.h"
#import "HCHomeTableViewCell.h"
#import "HCHomeInfo.h"
#import "HCHomeApi.h"
#import "HCHomeLikeCountApi.h"

#import "HCCreateGradeViewController.h"

#define HCHomeCell @"HCHomeTableViewCell"

@interface HCHomeFamilyViewController ()<HCHomeTableViewCellDelegate>

@property (nonatomic, strong) NSString *start;

@property (nonatomic, strong) HCWelcomeJoinGradeViewController *welcomJoinGrade;

@end

@implementation HCHomeFamilyViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self readLocationData];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCHomeTableViewCell class] forCellReuseIdentifier:HCHomeCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHomeData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreHomeData)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    HCHomeInfo *info = self.dataSource[indexPath.section];
    cell.info = info;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeInfo *info = self.dataSource[indexPath.section];
    HCHomeDetailViewController *detail = [[HCHomeDetailViewController alloc] init];
    detail.data = @{@"data": info};
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 60 + WIDTH(self.view)*0.15;
    
    HCHomeInfo *info = self.dataSource[indexPath.section];
    
    height = height + [Utils detailTextHeight:info.FTContent lineSpage:4 width:WIDTH(self.view)-20 font:14];
    
    if (!IsEmpty(info.FTImages))
    {
        if (info.FTImages.count < 5)
        {
            NSInteger row = ((int)info.FTImages.count/3) + 1;
            height += WIDTH(self.view) * 0.33 * row;
        }else
        {
            NSInteger row = ((int)MIN(info.FTImages.count, 9)/3.5) + 1;
            height += WIDTH(self.view) * 0.33 * row;
        }
    }
    
    if (!IsEmpty(info.CreateAddrSmall))
    {
        height = height + 30;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - HCHomeTableViewCellDelegate

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath functionIndex:(NSInteger)index
{
    HCHomeInfo *info = self.dataSource[indexPath.section];

    if (index == 2)
    {
        HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
        editComment.data = @{@"data": info};
        UIViewController *rootController = self.view.window.rootViewController;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            editComment.modalPresentationStyle=
            UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
        }else
        {
            rootController.modalPresentationStyle=
            UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
        }
        [rootController presentViewController:editComment animated:YES completion:nil];
    }else if (index == 1)
    {
        HCShareViewController  *shareVC = [[HCShareViewController alloc] init];
        [self presentViewController:shareVC animated:YES completion:nil];
    }else if (index == 0)
    {
        [self requestLikeCount:info indexPath:indexPath];
    }
}

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath moreImgView:(NSInteger)index
{
    HCHomePictureDetailViewController *pictureDetail = [[HCHomePictureDetailViewController alloc] init];
    pictureDetail.data = @{@"data": self.dataSource[indexPath.section], @"index": @(index)};
    pictureDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pictureDetail animated:YES];
}

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath seleteHead:(UIButton *)headBtn
{
    HCHomeInfo *info = self.dataSource[indexPath.section];
    HCHomeUserTimeViewController *userTime = [[HCHomeUserTimeViewController alloc] init];
    userTime.data = @{@"data": info};
    userTime.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userTime animated:YES];
}

#pragma mark - private methods

- (void)readLocationData
{
    NSString *path = [self getSaveLocationDataPath];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:path];

    [self.dataSource addObjectsFromArray:[HCHomeInfo mj_objectArrayWithKeyValuesArray:arrayData]];
    [self.tableView reloadData];
    [self requestHomeData];
}

- (NSString *)getSaveLocationDataPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"homedata.plist"];
}

- (void)writeLocationData:(NSArray *)array
{
    NSString *path = [self getSaveLocationDataPath];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i < array.count; i++)
    {
        HCHomeInfo *info = array[i];
        NSDictionary *dic = [info mj_keyValues];
        [arrayM addObject:dic];
    }
    [arrayM writeToFile:path atomically:YES];
}

#pragma mark - setter or getter

- (void)setGradeId:(NSString *)gradeId
{
    if (!IsEmpty(gradeId))
    {
        _welcomJoinGrade = [[HCWelcomeJoinGradeViewController alloc] init];
        _welcomJoinGrade.gradeId = [NSString stringWithFormat:@"欢迎加入%@班级", gradeId];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootController = window.rootViewController;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
          _welcomJoinGrade.modalPresentationStyle=
          UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
        }else
        {
          rootController.modalPresentationStyle=
          UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
        }
      [_welcomJoinGrade setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
      [rootController presentViewController:_welcomJoinGrade animated:YES completion:nil];
    }
}

#pragma mark - network

- (void)requestHomeData
{
    HCHomeApi *api = [[HCHomeApi alloc] init];
    api.Start = @"0";
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self.tableView.mj_header endRefreshing];
//        if (requestStatus == HCRequestStatusSuccess)
//        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            
            HCHomeInfo *lastInfo = [array lastObject];
            api.Start = lastInfo.KeyId;
            
            [self writeLocationData:array];
            [self.tableView reloadData];
//        }else
//        {
//            [self showHUDError:message];
//        }
    }];
    _baseRequest = api;
}

- (void)requestMoreHomeData
{
    HCHomeApi *api = [[HCHomeApi alloc] init];
    api.Start = _start;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self.tableView.mj_footer endRefreshing];
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource addObjectsFromArray:array];
            
            HCHomeInfo *lastInfo = [array lastObject];
            api.Start = lastInfo.KeyId;
            
            [self writeLocationData:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

// 请求点赞
- (void)requestLikeCount:(HCHomeInfo *)info indexPath:(NSIndexPath *)indexPath
{
    HCHomeLikeCountApi *api = [[HCHomeLikeCountApi alloc] init];
    api.TimesId = info.KeyId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            info.FTLikeCount = [NSString stringWithFormat:@"%@", @([info.FTLikeCount integerValue]+1)];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            [self showHUDError:message];
        }
    }];
}



@end
