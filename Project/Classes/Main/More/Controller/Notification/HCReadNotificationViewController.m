//
//  HCReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCReadNotificationViewController.h"
#import "HCButtonItem.h"
#import "HCNotificationCentereReadTableViewCell.h"
#import "HCNotificationCenterReadApi.h"
#import "HCNotificationCenterInfo.h"
#import "HCNotificationDetailViewController.h"

@interface HCReadNotificationViewController ()

@property (nonatomic,strong) NSMutableArray *mutableArray;

@end

@implementation HCReadNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
    
    
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *readNotificationID = @"readNotificationID";
    HCNotificationCentereReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:readNotificationID];
    if (!cell) {
        
        cell = [[HCNotificationCentereReadTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:readNotificationID];
        
        //修改删除按钮
        UIView *deletView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, 60)];
        HCButtonItem *deleteBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 0, 45, 60) WithImageName:@"Notification-Center_delete" WithImageWidth:80 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
        deletView.backgroundColor = [UIColor whiteColor];
        [deletView addSubview:deleteBtn];
        [cell.contentView addSubview:deletView];
        
        cell.info = self.dataSource[indexPath.section];
    }
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCNotificationDetailViewController *detailVC = [[HCNotificationDetailViewController alloc]init];
    detailVC.info = self.dataSource[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"  ";
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
    HCNotificationCenterReadApi *api = [[HCNotificationCenterReadApi alloc] init];
    
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
