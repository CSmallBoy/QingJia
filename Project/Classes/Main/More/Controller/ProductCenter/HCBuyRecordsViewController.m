//
//  HCBuyRecordsViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCBuyRecordsViewController.h"
#import "HCCustomerViewController.h"
#import "HCOrderOnlineViewController.h"
#import "HCLogisticsInfoViewController.h"
#import "HCAfterSalesApplyViewController.h"

#import "HCBuyRecordTableViewCell.h"


@interface HCBuyRecordsViewController ()
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@end

@implementation HCBuyRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买记录";
    [self setupBackItem];
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

#pragma mark--Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordID = @"record";
    HCBuyRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordID];
        cell = [[HCBuyRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];

            cell.indexPath = indexPath;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //在线订购
        HCOrderOnlineViewController *VC = [[HCOrderOnlineViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 1)
    {
        //物流信息
        HCLogisticsInfoViewController *VC = [[HCLogisticsInfoViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 2)
    {
        //物流信息
        HCLogisticsInfoViewController *VC = [[HCLogisticsInfoViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 3)
    {
        //售后申请
        HCAfterSalesApplyViewController *VC = [[HCAfterSalesApplyViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else
    {
        HCViewController *VC = [[HCViewController alloc]init];
        VC.title = @"待付款";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        return 50;
    }else
    {
        return 100;
    }
}



-(void)handleCustomer
{
    [self.navigationController pushViewController:[HCCustomerViewController new] animated:YES];
}

#pragma mark --- Setter Or  Getter


- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(handleCustomer)];
        _rightItem.title = @"售后";
        
        
    }
    return _rightItem;
}
@end
