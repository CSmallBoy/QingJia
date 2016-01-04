//
//  HCLogisticsInfoViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//已发货，已收货

#import "HCLogisticsInfoViewController.h"
#import "HCLogisticsInfo.h"
#import "HCLogisticsApi.h"

#import "HCProductIntroductionInfo.h"

#import "HCLogisticsInfoTableViewCell.h"
#import "HCLogisticsInfoTableViewCellSecond.h"

#import "HCBuyRecordTableViewCell.h"
@interface HCLogisticsInfoViewController ()

@property (nonatomic,strong) HCProductIntroductionInfo *info;

@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *beSureReceiveBtn;

@end

@implementation HCLogisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];
    [self requestHomeData];
    
    _info = self.data[@"data"];
    if (_info.orderState == 3) {
        self.beSureReceiveBtn.hidden = NO;
        self.title = @"已发货";
    }else
    {
        self.beSureReceiveBtn.hidden = YES;
        self.title = @"已签收";
    }
}

#pragma mark ----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if (indexPath.section == 0)
    {
        static NSString *RecordID = @"record";
        HCBuyRecordTableViewCell *buyRecordcell = [tableView dequeueReusableCellWithIdentifier:RecordID];
        
        buyRecordcell = [[HCBuyRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
        buyRecordcell.info = _info;
        buyRecordcell.indexPath= indexPath;
        buyRecordcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = buyRecordcell;
    }
    else
    {
        if (indexPath.row == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"followInfo"];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"followInfo"];
            cell.textLabel.text = @"跟进信息";
        }
        else
        {
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
        return 1;
    }else
    {
        return self.dataSource.count+1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 250;
    }else
    {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }else
    {
        return 60;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        view.backgroundColor = CLEARCOLOR;
        return view;
    }
    else
    {
        [_footerView addSubview:self.beSureReceiveBtn];
        return self.footerView;
    }

}

#pragma mark---Private method

-(void)clickBeSureBtn
{
    [self showHUDText:@"完成支付"];
}

#pragma mark---Setter OR Getter

-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _footerView.backgroundColor = CLEARCOLOR;
    }
    return _footerView;
}

-(UIButton *)beSureReceiveBtn
{
    if (!_beSureReceiveBtn)
    {
        _beSureReceiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _beSureReceiveBtn.backgroundColor = [UIColor redColor];
        [_beSureReceiveBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _beSureReceiveBtn.titleLabel.textColor = [UIColor whiteColor];
        _beSureReceiveBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 44);
        [_beSureReceiveBtn addTarget:self action:@selector(clickBeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beSureReceiveBtn;
}

#pragma mark---network

- (void)requestHomeData
{
    HCLogisticsApi *api = [[HCLogisticsApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array)
    {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }
     ];
    _baseRequest = api;
}
@end
