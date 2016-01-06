
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

@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *closeFollowBtn;

@end

@implementation HCFollowNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
    [self.view addSubview:self.footerView];
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
    return (indexPath.section == 1) ? 60: 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 1) ? 120 : 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
        return (section == 1) ? self.footerView : nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (IsEmpty(_info))
    {
        return 0;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0) ? 1 :7;
}


-(void)clickCloseFollowBtn
{
    [self showHUDText:@"已找到孩子，关闭跟进"];
}

-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 120)];
        _footerView.backgroundColor = RGB(236, 236, 236);
        [_footerView addSubview:self.closeFollowBtn];
    }
    return _footerView;
}

-(UIButton *)closeFollowBtn
{
    if (!_closeFollowBtn) {
        _closeFollowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeFollowBtn.frame = CGRectMake(20, 40, SCREEN_WIDTH-40, 40);
        _closeFollowBtn.backgroundColor = [UIColor redColor];
        [_closeFollowBtn setTitle:@"已找到孩子，关闭跟进" forState:UIControlStateNormal];
        [_closeFollowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_closeFollowBtn, 10);
        _closeFollowBtn.titleLabel.font = FONT(14);
        [_closeFollowBtn addTarget:self action:@selector(clickCloseFollowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeFollowBtn;
}

#pragma mark - network

- (void)requestHomeData
{
    HCNotificationCenterFollowAPI *api = [[HCNotificationCenterFollowAPI alloc] init];
    api.NoticeId = 1000000004;
    api.Start = 0;
    api.Count = 20;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCNotificationCenterInfo *info)
    {
        if (requestStatus == HCRequestStatusSuccess)
        {
            _info = info;
            [self.tableView reloadData];
        }else
        {
            _info = info;
            [self.tableView reloadData];
            [self showHUDError:message];
        }
    }];
}

@end
