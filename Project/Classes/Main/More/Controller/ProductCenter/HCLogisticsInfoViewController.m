//
//  HCLogisticsInfoViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//物流信息

#import "HCLogisticsInfoViewController.h"
#import "HCLogisticsInfo.h"
#import "HCLogisticsInfoTableViewCell.h"
#import "HCLogisticsInfoTableViewCellSecond.h"
@interface HCLogisticsInfoViewController ()

@end

@implementation HCLogisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流信息";
    [self setupBackItem];
    [self setupData];
    
}

#pragma mark ----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"lodisticsInfo";
    UITableViewCell* cell;
    if (indexPath.section == 0) {
        HCLogisticsInfoTableViewCell *cellF ;
        
        cellF = [tableView dequeueReusableCellWithIdentifier:cellID];
        cellF = [[HCLogisticsInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cellF.indexPath = indexPath;
        cell = cellF;
    }else
    {
        if (indexPath.row == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"followInfo"];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"followInfo"];
            cell.textLabel.text = @"跟进信息";
        }else{
            HCLogisticsInfoTableViewCellSecond *cellS;
            cellS = [tableView dequeueReusableCellWithIdentifier:@"lodisticsInfoSecond"];
            cellS = [[HCLogisticsInfoTableViewCellSecond alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lodisticsInfoSecond"];
            cellS.info = self.dataSource[indexPath.row-1];
            cellS.indexPath = indexPath;
            
            cell = cellS;
        }
        
    }
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }else
    {
        return self.dataSource.count+1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row != 2)
        {
            return 44;
        }else
        {
            return 100;
        }
    }else
    {
        return 50;
    }
}


- (void)setupData
{
    NSArray *imageNameArr = @[@"Notice", @"Notice", @"label", @"label", @"label"];
    NSArray *titleArr = @[@"我的推荐", @"我的简历", @"我申请的工作", @"我的收藏", @"我的足迹"];
    NSArray *timeArr = @[@"2015-01-14 08:00:20",@"2015-02-14 08:12:20",@"2015-03-14 08:00:20",@"2015-04-14 08:00:20",@"2015-05-14 08:00:20"];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        HCLogisticsInfo *info = [[HCLogisticsInfo alloc] init];
        info.imageName = imageNameArr[i];
        info.titleText = titleArr[i];
        info.detailText = timeArr[i];
        [self.dataSource addObject:info];
    }
}

@end
