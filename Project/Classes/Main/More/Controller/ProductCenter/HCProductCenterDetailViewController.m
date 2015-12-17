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

@interface HCProductCenterDetailViewController ()

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
    [self requestHomeData];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.tableView registerClass:[HCProductIntroductionCell class] forCellReuseIdentifier:IDCellF];
}


#pragma mark--UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        HCProductIntroductionCell *ProductIntroductionCell = [tableView dequeueReusableCellWithIdentifier:IDCellF];
    ProductIntroductionCell.indexPath = indexPath;
    ProductIntroductionCell.info = self.info;
    return ProductIntroductionCell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return 0;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 300;
    }else
    {
        return 132;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (IsEmpty(_info))
    {
        return nil;
    }
    if (section == 1)
    {
        return self.footerView;
    }else
    {
        return nil;
    }
    
}

#pragma mark - private methods

-(void)handleBuyBtn
{
    DLog(@"----%@", _info);
    [self.navigationController pushViewController:[HCCustomTagViewController new] animated:YES];
}

-(void)handleRightItem
{
    [self.navigationController pushViewController:[HCBuyRecordsViewController new] animated:YES];
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
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 64)];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(20, HEIGHT(_footerView)-40, WIDTH(self.view)-40, 45);
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(handleBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(buyBtn, 4);
    buyBtn.backgroundColor = RGB(253, 89, 83);
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
