//
//  HCContactPersonController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCContactPersonController.h"
#import "HCTagContactInfo.h"
#import "HCTagContactPersonCell.h"
#import "HCTagEditContractPersonController.h"

#import "HCContractPersonListApi.h"
#import "HCDeleteContactPersonApi.h"

#import "HCTagContactInfo.h"


@interface HCContactPersonController ()<UITableViewDataSource,UITableViewDelegate,SCSwipeTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView   *myTableView;
@property (nonatomic,strong) NSArray *btnArr;

@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCContactPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"紧急联系人";
    [self setupBackItem];
    
    [self.view addSubview:self.myTableView];
    
    [self.view addSubview:self.footerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuNextVC:) name:@"tuNextVC" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
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
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
    btn1.backgroundColor = COLOR(247, 68, 76, 1);
    UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
    imageView1.image = IMG(@"一呼百应详情－delete");
    [btn1 addSubview:imageView1];
    btn1.tag = 100;
    _btnArr = @[btn1];
    
    
    static NSString *cellIdentifier = @"HCTagContactPersonCell";
    HCTagContactPersonCell *cell = (HCTagContactPersonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HCTagContactPersonCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:cellIdentifier
                                                       withBtns:_btnArr
                                                      tableView:self.myTableView];
        cell.delegate = self;
    }
    cell.info = self.dataArr[indexPath.row];
    return cell;

}

#pragma mark --- SCSwipeTableViewCellDelegate

- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath
{
    HCTagContactInfo *info = self.dataArr[indexpath.row];
    
    HCDeleteContactPersonApi *api = [[HCDeleteContactPersonApi alloc]init];
    api.contactorId = info.contactorId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {

        if (requestStatus == HCRequestStatusSuccess) {
            
            [self.dataArr removeObjectAtIndex:indexpath.row];
            [self.myTableView reloadData];
            
        }
        else
        {
            NSString *str = respone[@"message"];
            [self showHUDText:str];
        }
    }];
}

#pragma mark --- private mothod

// 点击了新增紧急联系人
-(void)addContractPerson:(UIButton *)button
{
    
    HCTagEditContractPersonController *editVC = [[HCTagEditContractPersonController alloc]init];
    
    [self.navigationController pushViewController:editVC animated:YES];

}


// 点击了每一个Cell
-(void)tuNextVC:(NSNotification *)noti
{
    HCTagEditContractPersonController *editVC = [[HCTagEditContractPersonController alloc]init];
   
    editVC.info = noti.userInfo[@"info"];
    
    [self.navigationController pushViewController:editVC animated:YES];

    
}

#pragma mark --- setter Or getter


- (NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT-50)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 10, SCREEN_WIDTH-60, 30);
        ViewRadius(button, 5);
        button.backgroundColor = kHCNavBarColor;
        [button setTitle:@"+新增紧急联系人" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addContractPerson:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
    }
    return _footerView;
}


#pragma mark --- netWork

-(void)requestData
{
    HCContractPersonListApi *api = [[HCContractPersonListApi alloc]init];
    

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            
            [self.dataArr removeAllObjects];
            NSArray *array = respone[@"Data"][@"rows"];
            
            for (NSDictionary *dic in array) {
                HCTagContactInfo *info = [HCTagContactInfo  mj_objectWithKeyValues:dic];
                
                [self.dataArr addObject:info];
                
                
            }
            
            [self.myTableView reloadData];
            
        }
        
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
