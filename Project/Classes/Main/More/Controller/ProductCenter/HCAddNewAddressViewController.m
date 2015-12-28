//
//  HCAddNewAddressViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCAddNewAddressViewController.h"
#import "HCAddNewAddressTableViewCell.h"
#import "HCAddressApi.h"
#import "HCAddressInfo.h"

@interface HCAddNewAddressViewController ()

@property (nonatomic,strong) HCAddressInfo *info;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation HCAddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.title  = @"新增地址";
     self.navigationItem.rightBarButtonItem = self.rightItem;
    [self requestHomeData];
    
}

#pragma mark ----UITableViewDelegate


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addNewAddressID = @"addNewAddress";
    UITableViewCell *cell  = nil;
    
    if (!cell) {
            HCAddNewAddressTableViewCell *addNewAddCell = [tableView dequeueReusableCellWithIdentifier:addNewAddressID];
            addNewAddCell = [[HCAddNewAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addNewAddressID];
        addNewAddCell.indexPath = indexPath;
            cell = addNewAddCell;
    }
    return cell;
    
}

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
    if (indexPath.row == 4)
    {
        return 88;
    }
    else
    {
        return 44;
    }
    
}

#pragma mark----private methods

-(void)clickUseBtn
{
    [self showHUDText:@"保存成功"];
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(clickUseBtn)];
        _rightItem.title = @"使用";
        
    }
    return _rightItem;
}


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
