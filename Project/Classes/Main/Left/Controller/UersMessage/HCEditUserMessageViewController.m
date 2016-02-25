//
//  HCEditUserMessageViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditUserMessageViewController.h"
#import "HCEditUserMessageTableViewCell.h"
#import "HCChangeBoundleTelNumberControll.h"

@interface HCEditUserMessageViewController ()

@end

@implementation HCEditUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息编辑";
    [self setupBackItem];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    // 保存按钮
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem =right;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toChangeNumber) name:@"toChangeNumber" object:nil];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  11;
    }else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }else
    {
        return 20;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCEditUserMessageTableViewCell *cell = [HCEditUserMessageTableViewCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    
    return cell;

}


#pragma mark ---- private mothods
// 跳转绑定手机页面
-(void)toChangeNumber
{
    HCChangeBoundleTelNumberControll *changeVC = [[HCChangeBoundleTelNumberControll alloc]init];
    [self.navigationController pushViewController:changeVC animated:YES];
    
}

-(void)saveClick:(UIBarButtonItem *)item
{
  [self showHUDText:@"保存成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
