//
//  HCMtalkMyOrderListController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkAfterSaleController.h"
#import "HCMtalkMyOrderInfo.h"
#import "HCMTalkAfterSaleCell.h"
#import "HCMTalkApplyAfterSaleController.h"
#import "HCMtalkMyOrderFinisheController.h"
@interface HCMtalkAfterSaleController ()

@end

@implementation HCMtalkAfterSaleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"售后服务";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.backgroundColor = kHCBackgroundColor;
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNextVC) name:@"toNextVC" object:nil];
    
    
}


#pragma mark --- tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMTalkAfterSaleCell *cell = [HCMTalkAfterSaleCell cellWithTable:tableView];
    cell.info = self.dataSource[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMtalkMyOrderFinisheController *finished = [[HCMtalkMyOrderFinisheController alloc]init];
    [self.navigationController pushViewController:finished animated:YES];

}

#pragma mark --- private mothod

-(void)toNextVC
{
    HCMTalkApplyAfterSaleController *applyVC = [[HCMTalkApplyAfterSaleController alloc]init];
    [self.navigationController pushViewController:applyVC animated:YES];
}


#pragma mark ---- network

-(void)requestData
{
    NSArray *arr=@[@"",@"取消售后",@"取消售后"];
    
    for (int i = 0; i<3; i++) {
        
        HCMtalkMyOrderInfo *info = [[HCMtalkMyOrderInfo alloc]init];
        info.title = @"套餐A M-talk二维码标签10张+M-talk烫印机1个";
        info.price = @"￥9.9元";
        info.doWhat = arr[i];
        
        [self.dataSource addObject:info];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
