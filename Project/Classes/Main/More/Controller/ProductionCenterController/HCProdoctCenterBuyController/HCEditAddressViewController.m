//
//  HCAddNewAddressViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditAddressViewController.h"
#import "HCAddNewAddressTableViewCell.h"
#import "HCAddressApi.h"
#import "HCAddressInfo.h"

@interface HCEditAddressViewController ()

@property (nonatomic,strong) HCAddressInfo *info;

@end

@implementation HCEditAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //----------------------编辑地址-----------------------------
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.title  = @"编辑地址";
    [self setupBackItem];
    [self requestHomeData];
    
}

#pragma mark ----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addNewAddressID = @"editAddress";
    UITableViewCell *cell  = nil;
    if (!cell)
    {
        HCAddNewAddressTableViewCell *addNewAddCell = [tableView dequeueReusableCellWithIdentifier:addNewAddressID];
        addNewAddCell = [[HCAddNewAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addNewAddressID];
        
        
        HCAddressInfo *info =self.data[@"info"];
        addNewAddCell.info =  info;
        addNewAddCell.indexPath = indexPath;
            cell = addNewAddCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 4) ? 88 : 44;
}

#pragma mark----private methods

-(void)clickUseBtn
{
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---setter or getter


#pragma mark --Network

- (void)requestHomeData
{
    HCAddressApi *api = [[HCAddressApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCAddressInfo *info)
     {
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
