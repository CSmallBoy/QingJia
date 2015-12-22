//
//  HCUnReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUnReadNotificationViewController.h"
#import "HCButtonItem.h"
#import "HCNotificationCenterTableViewCell.h"
#import "HCNotificationCenterApi.h"
#import "HCNotificationCenterInfo.h"
@interface HCUnReadNotificationViewController ()


@property (nonatomic,strong) NSMutableArray *mutableArray;
@end

@implementation HCUnReadNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestHomeData];
    
}



#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unreadID = @"unread";
    HCNotificationCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unreadID];
    if (!cell) {
        
        cell = [[HCNotificationCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unreadID];
        cell.info = self.dataSource[indexPath.section];

    }
    return cell;
   
    
}


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"  ";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
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
//    [self.mutableArray removeObjectAtIndex:indexPath.section];
    [self.dataSource removeObjectAtIndex:indexPath.section];
    [tableView reloadData];
}


-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [[NSMutableArray alloc]initWithArray:@[@"1",@"2",@"3",@"4",@"5"]];
        
    }
    return _mutableArray;
}



#pragma mark - network

- (void)requestHomeData
{
    HCNotificationCenterApi *api = [[HCNotificationCenterApi alloc] init];
    
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
