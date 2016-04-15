//
//  HCTagEditContractPersonController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//----------------------编辑或新增紧急联系人界面------------------------------------

#import "HCTagEditContractPersonController.h"
#import "HCAddContactPersonApi.h"
#import "HCTagContactInfo.h"

@interface HCTagEditContractPersonController ()

@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@end

@implementation HCTagEditContractPersonController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    if (_info) {
        self.title = @"编辑紧急联系人";
    }else
    {
        self.title = @"新增紧急联系人";
    }
    [self setupBackItem];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    
}

#pragma mark ---  UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row == 0)
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 80, 30)];
        titleLabel.text = @"姓名";
        titleLabel.textColor = [UIColor blackColor];
        [cell addSubview:titleLabel];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 7, 200, 30)];
        textField.placeholder = @"点击输入姓名";
        textField.text = _info.trueName;
        textField.textColor = [UIColor blackColor];
        self.textField1 = textField;
        [cell addSubview:self.textField1];
        
    }
    else if (indexPath.row == 1)
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 80, 30)];
        titleLabel.text = @"手机号";
        titleLabel.textColor = [UIColor blackColor];
        [cell addSubview:titleLabel];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 7, 200, 30)];
        textField.placeholder = @"点击输入手机号";
        textField.text = _info.phoneNo;
        textField.textColor = [UIColor blackColor];
        self.textField2 = textField;
        
        [cell addSubview:self.textField2];
    }
    else
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 200, 30)];
        titleLabel.text = @"与标签试用者的关系";
        titleLabel.textColor = [UIColor blackColor];
        [cell addSubview:titleLabel];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(200, 7, 150, 30)];
        textField.placeholder = @"点击输入关系";
        textField.text = _info.relative;
        textField.textColor = [UIColor blackColor];
        [cell addSubview:textField];
    
    }
    
    return cell;
    
}

#pragma mark --- provate mothods

-(void)itemClick:(UIBarButtonItem *)item
{
    [self requestData];
}



#pragma mark --- netWork

-(void)requestData
{
    HCAddContactPersonApi *api = [[HCAddContactPersonApi alloc]init];
    
    [api startRequest:^(HCRequestStatus requesStatus, NSString *message, id respone) {
       
        if (requesStatus == HCRequestStatusSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showHUDText:@"保存失败"];
        }
        
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
