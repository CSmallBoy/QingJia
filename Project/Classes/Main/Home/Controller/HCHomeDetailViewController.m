//
//  HCHomeDetailViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeDetailViewController.h"
#import "HCHomeDetailTableViewCell.h"
#import "HCHomeDetailInfo.h"
#import "HCHomeInfo.h"
#import "HCHomeDetailApi.h"

#define HCHomeDetailCell @"HCHomeDetailTableViewCell"

@interface HCHomeDetailViewController ()

@end

@implementation HCHomeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"时光详情";
    [self setupBackItem];
    
    [self requestHomeDetail];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCHomeDetailTableViewCell class] forCellReuseIdentifier:HCHomeDetailCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 )
    {
        HCHomeInfo *info = self.data[@"data"];
        cell.info = info;
    }else
    {
        HCHomeDetailInfo *detailInfo = self.dataSource[indexPath.row];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 60 + WIDTH(self.view)*0.15;
    
    HCHomeInfo *info = self.data[@"data"];
    
    height = height + [Utils detailTextHeight:info.contents lineSpage:4 width:WIDTH(self.view)-20 font:14];
    
    if (!IsEmpty(info.imgArr))
    {
        height = height + (WIDTH(self.view)-30)/3;
    }
    
    return height;
}

#pragma mark - network

- (void)requestHomeDetail
{
    [self showHUDView:nil];
    
    HCHomeDetailApi *api = [[HCHomeDetailApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
