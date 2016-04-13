//
//  HCTagMangerMangerController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagMangerMangerController.h"
#import "HCContactPersonController.h"
#import "HCTagUserMangerController.h"

@interface HCTagMangerMangerController ()

@end

@implementation HCTagMangerMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    [self setupBackItem];
    // 扫描二维码的图标
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    IV.image = IMG(@"label_Head-Portraits");
    [cell.contentView addSubview:IV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    [cell.contentView addSubview:label];
    
    if (indexPath.row == 0)
    {
       label.text = @"紧急联系人管理";
    }else
    {
       label.text = @"标签使用者管理";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HCContactPersonController *personVC = [[HCContactPersonController alloc]init];
        [self.navigationController pushViewController:personVC animated:YES];
    
    }
    else
    {
        HCTagUserMangerController *userVC = [[HCTagUserMangerController alloc]init];
        [self.navigationController pushViewController:userVC animated:YES];
    
    }
}


#pragma mark --- private mothods

// 点击了扫描二维码额图标
-(void)rightItemClick:(UIBarButtonItem *)right
{

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
