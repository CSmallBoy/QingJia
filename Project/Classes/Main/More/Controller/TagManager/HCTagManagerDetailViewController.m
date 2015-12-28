
//
//  HCTagManagerDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagManagerDetailViewController.h"
#import "HCTagManagerInfo.h"



#define TagManagerDetailCell @"TagManagerDetailCell"

@interface HCTagManagerDetailViewController ()

@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) HCTagManagerInfo *info;


@end

@implementation HCTagManagerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(1);
    self.title = @"标签详情";
    _info = self.data[@"data"];
    NSLog(@"%@",_info.tagNameArr[_index]);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TagManagerDetailCell];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TagManagerDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0)
    {
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 200;
    }else
    {
        return 50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark --Setter Or Getter

-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}


@end
