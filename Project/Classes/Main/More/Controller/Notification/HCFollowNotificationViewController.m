
//
//  HCFollowNoticationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFollowNotificationViewController.h"
#import "HCButtonItem.h"

@interface HCFollowNotificationViewController ()

@property (nonatomic,strong) NSMutableArray *mutableArray;


@end

@implementation HCFollowNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}





-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *followNotificationID = @"followNotification";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followNotificationID];
    if (!cell)
    {  
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:followNotificationID];
        UIView *deletView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, 44)];
        HCButtonItem *deleteBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 0, 44, 44) WithImageName:@"Settings_icon_Cache_dis" WithImageWidth:44 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
        deletView.backgroundColor = [UIColor whiteColor];
        [deletView addSubview:deleteBtn];
        [cell.contentView addSubview:deletView];
    }
    
    UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-180, 0, 170, 20)];
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.text = @"2015年08月23日 12:10";
    timeLab.textColor = [UIColor lightGrayColor];
    
    cell.textLabel.text = @"M-Talk";
    cell.detailTextLabel.text = @"过将随机核苷酸编码的寡肽插入编码包被蛋白基因的开放读框末端，即可构建含有大量的具有不同结构和组成信息的噬菌体呈现表位文库";
    [cell.contentView addSubview:timeLab];
    
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
    return self.mutableArray.count;
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
    [self.mutableArray removeObjectAtIndex:indexPath.section];
    [tableView reloadData];
}


-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [[NSMutableArray alloc]initWithArray:@[@"1",@"2",@"3"]];
        
    }
    return _mutableArray;
}

@end
