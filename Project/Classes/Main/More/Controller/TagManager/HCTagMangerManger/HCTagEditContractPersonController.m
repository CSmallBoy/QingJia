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
#import "HCChangeContactPersonApi.h"
#import "HCAvatarMgr.h"

@interface HCTagEditContractPersonController ()

@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UITextField *textField3;
@property (nonatomic,strong) NSString *imgStr;
@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong)UIButton *headBtn;
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
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

#pragma mark ---  UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 80, 20)];
    titleLabel.text = @"姓名";
    titleLabel.textColor = [UIColor blackColor];
    [cell addSubview:titleLabel];
        
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(180, 20, 200, 20)];
    textField.placeholder = @"点击输入姓名";
    textField.text = _info.trueName;
    textField.textColor = [UIColor blackColor];
    self.textField1 = textField;
    [cell addSubview:self.textField1];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(110, 42, 200, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    
    [cell addSubview:lineView];
    
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 80, 20)];
    titleLabel1.text = @"手机号";
    titleLabel1.textColor = [UIColor blackColor];
    [cell addSubview:titleLabel1];
        
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(180, 50, 200, 20)];
    textField1.placeholder = @"点击输入手机号";
    textField1.text = _info.phoneNo;
    textField1.textColor = [UIColor blackColor];
    self.textField2 = textField1;
    [cell addSubview:self.textField2];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(110, 72, 200, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    
    [cell addSubview:lineView1];

    
   _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(10, 10, 80, 80);
    ViewRadius(_headBtn, 40);
    
    if (self.image) {
        [_headBtn setImage:self.image forState:UIControlStateNormal];
    }else
    {
        
        NSURL *url = [readUserInfo originUrl:self.info.imageName :@"contactor"];
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        if (image) {
              [_headBtn setImage:image forState:UIControlStateNormal];
        }
        else
        {
             [_headBtn setImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
        }
    }
    [_headBtn addTarget:self action:@selector(showAlbum) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:_headBtn];
    
    return cell;
    
}

#pragma mark --- provate mothods

-(void)itemClick:(UIBarButtonItem *)item
{
    if (self.info) {
        
        if (self.image) {
            [self upLoadImage];
        }else
        {
            [self chanageContactPerson];
        }
        
    }
    else
    {
    [self upLoadImage];
    }
    
    
}

-(void)showAlbum
{
    [self.view endEditing:YES];
    
    
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            [self.headBtn setImage:self.image forState:UIControlStateNormal];
            
        }
    }];
    
    
}


#pragma mark --- netWork

-(void)requestData
{
    HCAddContactPersonApi *api = [[HCAddContactPersonApi alloc]init];
    
    api.trueName = self.textField1.text;
    api.phoneNo = self.textField2.text;
    api.imgStr = self.imgStr;
    api.relative = self.textField3.text;
    
    [api startRequest:^(HCRequestStatus requesStatus, NSString *message, id respone) {
       
        if (requesStatus == HCRequestStatusSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            HCTagContactInfo *info = [[HCTagContactInfo alloc]init];
            info.trueName = self.textField1.text;
            info.phoneNo = self.textField2.text;
            info.imageName = self.imgStr;
            info.conactPersonImage = self.image;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewContractPerson" object:nil userInfo:@{@"info":info}];
        }
        else
        {
            [self showHUDText:@"保存失败"];
        }
        
    }];
   
}

-(void)upLoadImage
{
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",@"contactor",uuid,token]];
    if (self.image == nil)
    {
        self.image = IMG(@"Head-Portraits");
    }
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.imgStr = responseObject[@"Data"][@"files"][0];
        
        if (_info) {
        // 变更紧急联系人
            [self chanageContactPerson];
        }
        else
        {
        // 添加紧急联系人
            [self requestData];
        }
        
        
       
    } failure:^(NSError *error) {
        
    }];

 
}

-(void)chanageContactPerson
{

    HCChangeContactPersonApi *api = [[HCChangeContactPersonApi alloc]init];
    api.contactorId = self.info.contactorId;
    api.phoneNo = self.textField2.text;
    
    if (self.imgStr) {
        api.imageName = self.imgStr;
    }
    else
    {
        api.imageName = self.info.imageName;
    }

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
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
