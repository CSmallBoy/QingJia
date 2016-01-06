//
//  HCProductCenterDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProductCenterDetailViewController.h"
#import "HCBuyRecordsViewController.h"
#import "HCCustomTagViewController.h"
#import "HCProductIntroductionCell.h"
#import <MJExtension.h>
#import <MJExtension/MJExtension.h>
#import "HCProductIntroductionInfo.h"
#import "HCProductIntrodApi.h"


static NSString *IDCellF = @"introduction";

@interface HCProductCenterDetailViewController ()<HCProductIntroductionInfoDelegate>

@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIWebView *webView;

@property (nonatomic, strong) HCProductIntroductionInfo *info;


@end

@implementation HCProductCenterDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品详情";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestHomeData];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.tableView registerClass:[HCProductIntroductionCell class] forCellReuseIdentifier:IDCellF];
}


#pragma mark--UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        HCProductIntroductionCell *ProductIntroductionCell = [tableView dequeueReusableCellWithIdentifier:IDCellF];
    ProductIntroductionCell.delegate = self;
    ProductIntroductionCell.indexPath = indexPath;
    ProductIntroductionCell.info = self.info;
    ProductIntroductionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return ProductIntroductionCell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (IsEmpty(_info))
//    {
//        return 0;
//    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 300 : 275;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 1) ? 120 :10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == 1) ? self.footerView : nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - private methods

-(void)handleBuyBtn
{
    [self.navigationController pushViewController:[HCCustomTagViewController new] animated:YES];
}

-(void)handleRightItem
{
    [self.navigationController pushViewController:[HCBuyRecordsViewController new] animated:YES];
}

-(void)showForbidLabelDelete
{
    [self showHUDText:@"标签最小购买数为10"];

}

-(void)showForbidLabelAdd
{
    [self showHUDText:@"标签最大购买数为50"];
}

-(void)showForbidHotStampingMachineAdd
{
    [self showHUDText:@"烫印机最大购买数为5"];
}

-(void)showForbidHotStampingMachineDelete
{
    [self showHUDText:@"烫印机最小购买数量为0"];
}
#pragma mark---setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
        _rightItem.title = @"购买记录";
        
    }
    return _rightItem;
}

-(UIView *)footerView
{
    if(!_footerView)
    {
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 120)];
        
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(15, 40, WIDTH(self.view)-30, 44);
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(buyBtn, 4);
        buyBtn.backgroundColor = [UIColor redColor];
        
    [_footerView addSubview:buyBtn];
    }
    return _footerView;
    
}

#pragma mark - network

- (void)requestHomeData
{
    HCProductIntrodApi *api = [[HCProductIntrodApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCProductIntroductionInfo *info) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            _info = info;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

@end
