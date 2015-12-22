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
//        cell.indexPath = indexPath;
        
//        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unreadID];
//        UIView *deletView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, 44)];
//        HCButtonItem *deleteBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 0, 44, 44) WithImageName:@"Settings_icon_Cache_dis" WithImageWidth:44 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
//        deletView.backgroundColor = [UIColor whiteColor];
//        [deletView addSubview:deleteBtn];
//        [cell.contentView addSubview:deletView];
//    }
//    
//    UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-180, 0,170, 20)];
//    timeLab.textAlignment = NSTextAlignmentRight;
//    timeLab.font = [UIFont systemFontOfSize:12];
//    [cell.contentView addSubview:timeLab];
//    timeLab.text = [NSString stringWithFormat:@"2015年08月23日 12:10"];
//    cell.textLabel.text = @"M-Talk";
//    cell.detailTextLabel.text = @"丝状噬菌体表面呈现技术自1985年至今已逐渐成熟，通过将随机核苷酸编码的寡肽插入编码包被蛋白基因的开放读框末端，即可构建含有大量的具有不同结构和组成信息的噬菌体呈现表位文库";
//    timeLab.textColor = [UIColor lightGrayColor];
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
