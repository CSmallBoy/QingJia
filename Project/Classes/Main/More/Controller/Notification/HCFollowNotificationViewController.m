
//
//  HCFollowNoticationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFollowNotificationViewController.h"
#import "HCNotificationCenterFollowTableViewCell.h"
#import "HCNotificationCenterFollowAPI.h"
#import "HCNotificationCenterInfo.h"

#import "HCNotificationCentereReadTableViewCell.h"

@interface HCFollowNotificationViewController ()

@property (nonatomic,strong) HCNotificationCenterInfo *info;

@end

@implementation HCFollowNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *followID = @"FollowNotificationID";
    
    UITableViewCell *cell;
    if (indexPath.section == 0)
    {
     HCNotificationCentereReadTableViewCell *messageCell  = [[HCNotificationCentereReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:followID];
        messageCell.info = _info;
        
        cell = messageCell;
    }
    else if(indexPath.section ==1)
    {
        if (indexPath.row == 0)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"follow0"];
            cell.textLabel.text = @"跟进信息";
        }else if (indexPath.row != 0 )
        {
           HCNotificationCenterFollowTableViewCell * followInfoCell = [[HCNotificationCenterFollowTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"follow"];
            followInfoCell.info = _info;
            followInfoCell.indexPath = indexPath;
            cell = followInfoCell;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 75;
    }else
    {
    return 60;
    }
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
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return 0;
    }
    if (section == 0)
    {
        return 1;
    }else
    {
        
        return 7;
    }
}

#pragma mark - network

- (void)requestHomeData
{
    HCNotificationCenterFollowAPI *api = [[HCNotificationCenterFollowAPI alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCNotificationCenterInfo *info)
    {
        if (requestStatus == HCRequestStatusSuccess)
        {
            _info = info;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

@end
