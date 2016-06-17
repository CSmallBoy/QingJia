
//
//  HCTagManagerDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//已激活标签详情

#import "HCTagManagerDetailViewController.h"
#import "HCNewTagInfo.h"

#import "HCTagDetailHeaderView.h"
#import "HCTagDetailTableViewCell.h"

#import "HCHeathViewController.h"
#import "HCeditingViewController.h"
#import "HCTagClosedDetailViewControllwe.h"

#import "HCTagDetailApi.h"

#import "HCMedicalViewController.h"
#import "HCAddTagUserController.h"

#import "HCTagStopUseApi.h"


#define TagManagerDetailCell @"TagManagerDetailCell"

@interface HCTagManagerDetailViewController (){
    BOOL ool;
    UIButton *button;
    UIButton *button2;
    UIView *view_all;
    UIImageView *button_view;
}

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) HCNewTagInfo *info;
@property (nonatomic,strong) UIImageView *tagImageView;

@property (nonatomic,strong)UIImageView *header_button;


@property (nonatomic, strong)UIView *alertBackground;//弹出提示框时的灰色背景
@property (nonatomic, strong)UIView *customAlertView;//自定义提示框

@end

@implementation HCTagManagerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    _info = self.data[@"data"];
    self.tableView.tableHeaderView = self.headerView;
    self.title = @"标签详情";
    [self.tableView registerClass:[HCTagDetailTableViewCell class] forCellReuseIdentifier:TagManagerDetailCell];
    if (_isStop) {
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"已停用" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.rightBarButtonItem = item;
    }
    else
    {
        UIBarButtonItem *add_bar_button = [[UIBarButtonItem alloc]initWithImage:IMG(@"导航条－inclass_Plus") style:UIBarButtonItemStylePlain target:self action:@selector(add_click)];
        ool = YES;
        self.navigationItem.rightBarButtonItem = add_bar_button;
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ool = YES;
    [self requestData];
}

-(void)add_click{
    NSLog(@"%d",ool);
    if (ool) {
        button_view.hidden = NO;
       
    }else{
         button_view.hidden = YES;
    }
    ool =!ool;
    
    
}
#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        // 电话图标  联系人
        NSString *contact1 = [NSString stringWithFormat:@"%@(%@)",_info.relation1,_info.contactorPhoneNo1];
        NSString *contact2 = [NSString stringWithFormat:@"%@(%@)",_info.relation2,_info.contactorPhoneNo2];
        
        NSArray *arr =@[contact1,contact2];
        UIView *view2 = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view2.backgroundColor = kHCBackgroundColor;
        for (int i = 0 ; i < 2; i ++) {
            UIImageView *image_phone = [[UIImageView alloc]initWithFrame:CGRectMake(100 + i * 130, 15, 20, 20)];//父亲电话图标
            image_phone.image = [UIImage imageNamed:@"PHONE-2"];
            UILabel *phone_num = [[UILabel alloc]initWithFrame:CGRectMake(130 + i * 130, 12, 100, 30)];
            phone_num.font = [UIFont systemFontOfSize:13];
            phone_num.text = arr[i];
            [view2 addSubview:image_phone];
            [view2 addSubview:phone_num];
        }
        
        [cell addSubview:view2];
        
        return cell;
        
    }
    
    HCTagDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TagManagerDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = self.info;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark--UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==6) {
        
        HCMedicalViewController *heathVc= [[HCMedicalViewController alloc]init];
//        HCHeathViewController *heathVc = [[HCHeathViewController alloc]init];
        
        heathVc.height = _info.height;
        heathVc.weight = _info.weight;
        heathVc.bloodType = _info.bloodType;
        heathVc.allergic = _info.allergic;
        heathVc.cureCondition = _info.cureCondition;
        heathVc.cureNote = _info.cureNote;
        [self.navigationController pushViewController:heathVc animated:YES];
    }
}
#pragma mark --Setter Or Getter

- (UIView *)alertBackground
{
    if (_alertBackground == nil)
    {
        _alertBackground = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _alertBackground.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_alertBackground addSubview:self.customAlertView];
    }
    return _alertBackground;
}


- (UIView *)customAlertView
{
    if (_customAlertView == nil)
    {
        _customAlertView = [[UIView alloc] initWithFrame:CGRectMake(30/375.0*SCREEN_WIDTH, 230/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-60/375.0*SCREEN_WIDTH, 190/668.0*SCREEN_HEIGHT)];
        ViewRadius(_customAlertView, 5);
        _customAlertView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55/668.0*SCREEN_HEIGHT, WIDTH(_customAlertView), 20/668.0*SCREEN_HEIGHT)];
        titleLabel.text = @"确认是否永久停用该标签";
        titleLabel.textAlignment = 1;
        [_customAlertView addSubview:titleLabel];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(30/375.0*SCREEN_WIDTH, MaxY(titleLabel)+45/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        ViewRadius(sureButton, 5);
        sureButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        sureButton.layer.borderWidth = 1;
        sureButton.tag = 1000;
        [sureButton setTitle:@"是" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(label_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:sureButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(MaxX(sureButton)+15/375.0*SCREEN_WIDTH, MaxY(titleLabel)+45/668.0*SCREEN_HEIGHT, 120/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        ViewRadius(cancelButton, 5);
        cancelButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        cancelButton.layer.borderWidth = 1;
        cancelButton.tag = 1001;
        [cancelButton setTitle:@"否" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(label_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customAlertView addSubview:cancelButton];
    }
    return _customAlertView;
}


-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:self.tagImageView];

        
        
    }
    // 头像
    UIImageView *header_button = [[UIImageView alloc]initWithFrame:CGRectMake(10, 170, 70, 70)];
    _header_button = header_button;
    ViewRadius(_header_button, 35);
    [_headerView addSubview:_header_button];
    
    //添加的button
    button_view= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 90, 72)];
    button_view.userInteractionEnabled = YES;
    button_view.image = [UIImage imageNamed:@"group"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 4, 90, 34);
    [button setTitle:@"编辑标签" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setBackgroundColor:[UIColor clearColor]];
    
    [button addTarget:self action:@selector(editingClick) forControlEvents:UIControlEventTouchUpInside];
   
    [button_view addSubview:button];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0,38, 90, 34);
    [button2 setBackgroundColor:[UIColor clearColor]];
    [button2 setTitle:@"停用标签" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    [button2 addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
     button_view.hidden= YES;
    [button_view addSubview:button2];
    [_headerView addSubview:button_view];
    
    return _headerView;
}

//编辑标签
-(void)editingClick{
    button_view.hidden = YES;
    HCAddTagUserController *editVC = [[HCAddTagUserController alloc]init];
    editVC.data = @{@"info":self.info};
    editVC.isEdit = YES;
    editVC.isEditTag = YES;
    editVC.isNewObj = NO;
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)stopClick
{
    [self.navigationController.view addSubview:self.alertBackground];
}
-(void)label_buttonClick:(UIButton*)buttton{
    switch (buttton.tag) {
        case 1000:
        {
            [self.alertBackground removeFromSuperview];
            [self requestStopApi];
        }
            break;
        case 1001:
        {
            [self.alertBackground removeFromSuperview];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark --- setter Or getter


- (UIImageView *)tagImageView
{
    if(!_tagImageView){
        _tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _tagImageView;
}



#pragma mark --- network

-(void)requestData
{
    HCTagDetailApi *api = [[HCTagDetailApi alloc]init];
    
    api.labelId = self.tagID;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        NSDictionary *dic = respone[@"Data"][@"labelInf"];
        
        HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
        
        self.info = info;
        self.info.objectId = self.objectId;
        
        NSURL *url = [readUserInfo originUrl:_info.imageName :kkObject];
        
        [_header_button sd_setImageWithURL:url placeholderImage:IMG(@"2Dbarcode_message_HeadPortraits")];
        
        NSURL *url1 = [readUserInfo originUrl:_info.labelImageName :kkLabel];
        [self.tagImageView sd_setImageWithURL:url1 placeholderImage:IMG(@"head.jpg")];
        
        [self.tableView reloadData];
        
    }];
  
}


-(void)requestStopApi
{
    HCTagStopUseApi *api = [[HCTagStopUseApi alloc]init];
    
    api.labelId = self.tagID;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestStopData" object:nil];
        }
        
    }];

}

@end
