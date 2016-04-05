//
//  HCMtalkWaitReceivedDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkWaitReceivedDetailController.h"
#import "HCMyOrderFollowInfo.h"
#import "HCMyOrderFollowCell.h"

@interface HCMtalkWaitReceivedDetailController ()

@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) UITableView  *myTableView;

@end

@implementation HCMtalkWaitReceivedDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
// -------------------------------待收货 （详情）--------------------------------------
    self.title = @"待收货";
    [self setupBackItem];
    [self requestData];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.myTableView];
}


#pragma mark --- tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 6;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 8;
    }
    else
    {
        return 0.1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 120;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return 44;
        }
        else
        {
            return 60;
        }
    
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0)
    {
        
        UIImageView * bigIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        bigIV.image = IMG(@"1");
        [cell addSubview:bigIV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH-120, 40)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@"套餐A M-talk二维码标签10张+M-talk烫印机1个" ];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 2)];
        
        label.attributedText = attStr;
        label.numberOfLines = 0;
        [cell addSubview:label];
        
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(120,CGRectGetMaxY(label.frame) +5, 50, 20)];
        numLabel.text = @"X1";
        numLabel.textColor = [UIColor blackColor];
        [cell addSubview:numLabel];
        
        UILabel *priceLabe = [[UILabel alloc]initWithFrame:CGRectMake(120,CGRectGetMaxY(numLabel.frame)+5, 80, 30)];
        priceLabe.textColor = [UIColor blackColor];
        priceLabe.text = @"￥9.9元";
        [cell addSubview:priceLabe];
    }else
    {
        if (indexPath.row == 0)
        {
           cell.textLabel.text = @"跟进信息";
        }
        else
        {
            HCMyOrderFollowCell *cell1 = [HCMyOrderFollowCell cellWithTableView:tableView];
            HCMyOrderFollowInfo *info = self.dataSource[indexPath.row-1];
            cell1.info =info;
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell1;
            
        }
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --- getter Or setter


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 10,SCREEN_WIDTH-30, 30);
        [button setBackgroundColor:COLOR(222, 35, 46, 1)];
        [button setTitle:@"确认收货" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(button, 5);
        [_footerView addSubview:button];
    }
    return _footerView;
}


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50-64) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = kHCBackgroundColor;
    }
    return _myTableView;
}


#pragma mark --- netWork
-(void)requestData
{
    
    NSArray *arr = @[@"已经到达顺丰快递南头站",@"已经到达深圳市顺丰快递集散中心",@"已经出上海市，发往深圳市顺丰快递集散中心",@"顺丰快递已经揽件正在出库",@"已经确认订单"];
    
    for (int i = 0; i<5; i++ ) {
        HCMyOrderFollowInfo *info = [[HCMyOrderFollowInfo alloc]init];
        info.adress = arr[i];
        info.time = @"2015-12-8 8:00";
        
        if (i ==0) {
            info.isArrived = YES;
        }
        else
        {
            info.isArrived = NO;
        }
        
        [self.dataSource addObject:info];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
