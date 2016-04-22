//
//  HCNotificationDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationDetailViewController.h"
#import "UILabel+HCLabelContentSize.h"
#import "HCButtonItem.h"
#import "HCPromisedViewController.h"

#import "HCNotificationDetailInfo.h"

#import "Utils.h"

@interface HCNotificationDetailViewController ()

@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) HCButtonItem *messageBtn;
@property (nonatomic,strong) HCButtonItem *MTalkBtn;
@property (nonatomic,strong) HCButtonItem *policeBtn;

@property (nonatomic,strong) HCNotificationDetailInfo *info;

@end

@implementation HCNotificationDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"信息详情";
    [self setupBackItem];
    [self requestHomeData];
    self.tableView.tableHeaderView = HCTabelHeadView(200);
    self.view.backgroundColor = [UIColor whiteColor];



}

#pragma mark --- tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enen"];
    if (cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"enen"];
        
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}


#pragma mark -- private method

-(void)pushTOPromised
{
    NSString *tel = [NSString stringWithFormat:@"tel://02134537916"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打客服电话"];
//    HCPromisedViewController *promisedVC = [[HCPromisedViewController alloc]init];
//    [self.navigationController pushViewController:promisedVC animated:YES];
}

-(void)ContactCustomerService
{
    [self showHUDText:@"留言"];
}

-(void)ContactWithPolice
{
    NSString *tel = [NSString stringWithFormat:@"tel://10086"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打110"];
}

#pragma mark----Settet OR Getter


-(UIView *)footerView
{
    if (!_footerView)
    {
//        CGFloat footerViewY = MAX(SCREEN_HEIGHT-61,self.notificationMessLab.frame.size.height+120);
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,20 , SCREEN_WIDTH, 60)];
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 1)];
        topView.backgroundColor = [UIColor lightGrayColor];
        [_footerView addSubview:topView];
        
        UIView *lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-1, 10, 1, 40)];
        lineViewOne.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewOne];
       
        UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2-2, 10, 1, 40)];
        lineViewTwo.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewTwo];
        
        [_footerView addSubview: self.messageBtn];
        [_footerView addSubview: self.MTalkBtn];
        [_footerView addSubview: self.policeBtn];
    }
    return _footerView;
}

-(HCButtonItem *)MTalkBtn
{
    //message_phone  m-talk_Customer-Services
    if (!_MTalkBtn)
    {
        _MTalkBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"m-talk_Customer-Services" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"M-Talk客服", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_MTalkBtn addTarget:self action:@selector(pushTOPromised) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MTalkBtn;
}

-(HCButtonItem *)messageBtn
{
    if (!_messageBtn)
    {
        _messageBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"Bubble_nor-2" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"留言", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_messageBtn addTarget:self action:@selector(ContactCustomerService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

-(HCButtonItem *)policeBtn
{
    if (!_policeBtn)
    {
        _policeBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"110" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"快速报警", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_policeBtn addTarget:self action:@selector(ContactWithPolice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _policeBtn;
}

#pragma mark - network

- (void)requestHomeData
{
    

    
    [self.dataSource addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
    

}


-(void)changeReadState
{

}
@end
