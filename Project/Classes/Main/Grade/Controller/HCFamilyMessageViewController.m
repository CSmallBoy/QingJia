//
//  HCFamilyMessageViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCFamilyMessageViewController.h"
#import "AppDelegate.h"
#import "HCCreateGradeInfo.h"

#import "applyToFamily.h"

@interface HCFamilyMessageViewController ()

@property (nonatomic,strong) HCCreateGradeInfo *info;
@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *familyNickNameLabel;
@property (nonatomic,strong) UILabel *ancestralHomeLabel;
@property (nonatomic,strong) UILabel *contactAddrLabel;

@end

@implementation HCFamilyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭信息";
    [self setupBackItem];
    self.info = self.data[@"info"];
    self.message = self.data[@"message"];
    
    self.view.backgroundColor = kHCBackgroundColor;
    self.tableView.tableFooterView = HCTabelHeadView(0.1);
}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
    {
    return 8;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 80;
    }
    else
    {
        return 44;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 40, SCREEN_WIDTH-30, 30);
        button.backgroundColor = kHCNavBarColor;
        ViewRadius(button, 5);
        [button setTitle:@"确认加入" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:kHCNavBarColor];
        [view addSubview:button];
        return view;
        
    }
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section ==0) {
       NSString *string = @"http://58.210.13.58:8090/uploads/images/defaultFamily.png";
        NSURL *url = [NSURL URLWithString:string];
        
        [self.headImg sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
        
        [cell.contentView addSubview:self.headImg]; 
        [cell.contentView addSubview:self.familyNickNameLabel];
    }else if (indexPath.section ==1 && indexPath.row == 0) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 40, 20)];
        label.text = @"祖籍";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:self.ancestralHomeLabel];
        
    }else if (indexPath.section == 1 && indexPath.row == 1)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 40, 20)];
        label.text = @"住址";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:self.contactAddrLabel];
        
    }
    
    return cell;
    
}

#pragma mark ---- private mothods

-(void)buttonClick
{
    if (IsEmpty(self.message)) {
        self.message = @" ";
        //[self showHUDText:@"验证消息不能为空"];
    }
    
    applyToFamily *api = [[applyToFamily alloc]init];
    api.familyId = self.info.familyId;
    api.joinMessage = self.message;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"申请已经发送"];
            [self performSelector:@selector(toHomeViewController) withObject:nil afterDelay:1.2];
        }
        else
        {
            [self showHUDText:message];
        }
        
  
        
    }];
}
- (void)toHomeViewController
{
    // 请求成功后，进入时光主页
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.showWelcomeJoinGradeID = self.info.familyId;
    [app setupRootViewController];
}

#pragma mark --- getter Or setter 


- (UIImageView *)headImg
{
    if(!_headImg){
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        _headImg.backgroundColor = [UIColor redColor];
        ViewRadius(_headImg, 30);
    }
    return _headImg;
}


- (UILabel *)familyNickNameLabel
{
    if(!_familyNickNameLabel){
        _familyNickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 100, 20)];
        _familyNickNameLabel.text = self.info.familyNickName;
        _familyNickNameLabel.textColor = [UIColor blackColor];
        _familyNickNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _familyNickNameLabel;
}


- (UILabel *)ancestralHomeLabel
{
    if(!_ancestralHomeLabel){
        _ancestralHomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 7, SCREEN_WIDTH-100, 20)];
        _ancestralHomeLabel.text = self.info.ancestralHome;
        _ancestralHomeLabel.textColor = [UIColor blackColor];
        _ancestralHomeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _ancestralHomeLabel;
}


- (UILabel *)contactAddrLabel
{
    if(!_contactAddrLabel){
        _contactAddrLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 7, SCREEN_WIDTH-100, 20)];
        _contactAddrLabel.text = self.info.contactAddr;
        _contactAddrLabel.textColor = [UIColor blackColor];
        _contactAddrLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contactAddrLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
