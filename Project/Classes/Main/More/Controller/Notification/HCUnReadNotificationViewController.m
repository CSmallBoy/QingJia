//
//  HCUnReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//未读信息

#import "HCUnReadNotificationViewController.h"
#import "HCButtonItem.h"
#import "HCNotificationCenterUnreadTableViewCell.h"
#import "HCNotificationCenterApi.h"
#import "HCNotificationCenterInfo.h"
#import "HCNotificationDetailViewController.h"

@interface HCUnReadNotificationViewController ()

@end

@implementation HCUnReadNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
}



#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unreadID = @"unread";
    HCNotificationCenterUnreadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unreadID];
    if (!cell)
    {
        cell = [[HCNotificationCenterUnreadTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unreadID];
        cell.info = self.dataSource[indexPath.section];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCNotificationDetailViewController *detailVC = [[HCNotificationDetailViewController alloc]init];
//    detailVC.info = self.dataSource[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSource removeObjectAtIndex:indexPath.section];
    [tableView reloadData];
}

#pragma mark - network

- (void)requestHomeData
{
    HCNotificationCenterApi *api = [[HCNotificationCenterApi alloc] init];
    api.NoticeType = 100;
    api.theStatus = @"未读";
    api.Start = 1000;
    api.Count = 20;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        else
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
            [self showHUDError:message];
        }
    }];
}

@end
