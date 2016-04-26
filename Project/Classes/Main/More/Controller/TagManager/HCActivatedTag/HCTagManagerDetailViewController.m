
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
    
    [self requestData];
}

-(void)add_click{
    NSLog(@"%d",ool);
    if (ool) {
        button_view.hidden = NO;
       
    }else{
            //[button removeFromSuperview];
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
    button_view= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 90, 63)];
    button_view.userInteractionEnabled = YES;
    button_view.image = [UIImage imageNamed:@"group"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2, 90, 30);
    [button setTitle:@"编辑标签" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setBackgroundColor:[UIColor clearColor]];
    
    [button addTarget:self action:@selector(editingClick) forControlEvents:UIControlEventTouchUpInside];
   
    [button_view addSubview:button];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0,33, 90, 30);
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
    
    [button2 removeFromSuperview];
    [button_view removeFromSuperview];
    
    HCAddTagUserController *editVC = [[HCAddTagUserController alloc]init];
    editVC.data = @{@"info":self.info};
    editVC.isEdit = YES;
    editVC.isEditTag = YES;
    [self.navigationController pushViewController:editVC animated:YES];

    
}
-(void)stopClick{
    NSArray *arr = @[@"停用",@"取消"];
    view_all = [[UIView alloc]initWithFrame:self.view.bounds];
    view_all.backgroundColor  = [UIColor grayColor];
    view_all.alpha = 0.97;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2,SCREEN_HEIGHT*0.33, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.3)];
    view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0 ; i < 2; i ++) {
        UIButton *label_button = [UIButton buttonWithType:UIButtonTypeCustom];
        label_button.frame = CGRectMake(10,SCREEN_HEIGHT*0.32*0.5+35*i , SCREEN_WIDTH*0.6-20, 28);
        label_button.tag = 1000+i;
        [label_button setTitle:arr[i] forState:UIControlStateNormal];
        [label_button addTarget:self action:@selector(label_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [label_button setBackgroundColor:[UIColor redColor]];
        }else{
            [label_button setBackgroundColor:[UIColor blueColor]];
        }
        [view addSubview:label_button];
    }
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(view.bounds.size.width*0.1, 15, view.bounds.size.width*0.8, 50)];
    alert_label.text = @"确认是否永久停用该标签!";
    alert_label.numberOfLines = 0;
    [view addSubview:alert_label];
    ViewBorderRadius(view, 10, 0, CLEARCOLOR);
    [view_all addSubview:view];
    [self.view addSubview:view_all];
    
}
-(void)label_buttonClick:(UIButton*)buttton{
    switch (buttton.tag) {
        case 1000:
        {
            [self requestStopApi];
        }
            break;
        case 1001:
        {
            [view_all removeFromSuperview];
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
