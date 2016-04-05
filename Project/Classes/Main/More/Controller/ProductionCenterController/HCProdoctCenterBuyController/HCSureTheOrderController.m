//
//  HCSureTheOrderController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCSureTheOrderController.h"
#import "HCPayViewController.h"

#import "HCMtalkShopingInfo.h"
#import "HCSureOrderCell.h"

@interface HCSureTheOrderController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) UIView   *footerView;
@property (nonatomic,strong) HCMtalkShopingInfo *info;
@property (nonatomic,strong) UILabel  *allPriceLabel;
@end

@implementation HCSureTheOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    //------------------------确认订单-----------------------------------
    self.title = @"确认订单";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    self.info = self.data[@"info"];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
    
}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCSureOrderCell *cell = [HCSureOrderCell cellWithTableView:tableView];
    cell.info = self.info;
    
    cell.block = ^(NSInteger num){

        self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元",(long)num *[self.info.price floatValue]];
    
    };
    
    return cell;
}

#pragma mark --- provite mothods

-(void)sureReport:(UIButton *)btn
{
    HCPayViewController *payVC = [[HCPayViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
  
}

#pragma mark --- getter Or setter


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = kHCBackgroundColor;
    }
    return _myTableView;
}

- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH *0.6, 60)];
        leftView.backgroundColor = [UIColor lightGrayColor];
        
        [leftView addSubview:self.allPriceLabel];
        
        UILabel *disCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,40 , SCREEN_WIDTH * 0.5, 20)];
        disCountLabel.text = @"满一百减二十：-￥20";
        disCountLabel.font = [UIFont systemFontOfSize:12];
        [leftView addSubview:disCountLabel];
        
        [_footerView addSubview:leftView];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH*0.6,0 , SCREEN_WIDTH*0.4, 60);
        rightBtn.backgroundColor = kHCNavBarColor;
        [rightBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(sureReport:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:rightBtn];
        
    }
    return _footerView;
}



- (UILabel *)allPriceLabel
{
    if(!_allPriceLabel){
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5,SCREEN_WIDTH*0.3, 30)];
        _allPriceLabel.textColor = [UIColor blackColor];
        _allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%@元",self.info.price ];
        _allPriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _allPriceLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
