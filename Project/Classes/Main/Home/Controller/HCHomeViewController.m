//
//  HCHomeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeViewController.h"
#import "HCPublishViewController.h"
#import "HCHomeTableViewCell.h"
#import "HCHomeInfo.h"
#import "HCHomeApi.h"

#define HCHomeCell @"HCHomeTableViewCell"

@interface HCHomeViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation HCHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"M-时光";
    
    [self requestHomeData];
    
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCHomeTableViewCell class] forCellReuseIdentifier:HCHomeCell];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeCell];
    HCHomeInfo *info = self.dataSource[indexPath.section];
    cell.info = info;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100;
    
    HCHomeInfo *info = self.dataSource[indexPath.section];
    
    height = height + [Utils detailTextHeight:info.contents lineSpage:5 width:WIDTH(self.view)-20 font:15];
    
    if (!IsEmpty(info.imgArr))
    {
        height = height + (WIDTH(self.view)-30)/3;
    }
    
    if (!IsEmpty(info.address))
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

#pragma mark - private methods

- (void)handleLeftItem
{
    
}

- (void)handleRightItem
{
    HCPublishViewController *publish = [[HCPublishViewController alloc] init];
    publish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publish animated:YES];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)leftItem
{
    if (!_leftItem)
    {
        _leftItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_right Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftItem)];
    }
    return _leftItem;
}

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_left Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

#pragma mark - network

- (void)requestHomeData
{
    HCHomeApi *api = [[HCHomeApi alloc] init];
    
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
