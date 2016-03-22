//
//  HCProductShopingCarController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductShopingCarController.h"

#import "HCShopingCarCell.h"

#import "HCMtalkShopingInfo.h"


@interface HCProductShopingCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray  *dataArr;
@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) UILabel *allPriceLabel;
@property (nonatomic,assign) CGFloat allPrice;
@end

@implementation HCProductShopingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
   // -------------------购物车-------------------------------
    self.title = @"购物车";
    [self setupBackItem];
    [self requestData];
    _allPrice = 0;
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    HCShopingCarCell *cell = [HCShopingCarCell cellWithTableView:tableView];
    cell.info = self.dataArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMtalkShopingInfo *info = self.dataArr[indexPath.section];
    
    if (info.isSelect == NO) {
         info.isSelect = YES;
        if (info.allPrice.length>0) {
            CGFloat price = [info.allPrice floatValue];
            _allPrice = _allPrice +price;
        }
        else
        {
            CGFloat price = [info.price floatValue];
            _allPrice = _allPrice +price;
        }
        
        
        self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元 ",_allPrice];

    }
    else
    {
        info.isSelect = NO;
    }
    
   
    [self.myTableView reloadData];
    
    
}


#pragma mark ---  setter  Or getter


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
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
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
        [rightBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_footerView addSubview:rightBtn];
        
    }
    return _footerView;
}


- (UILabel *)allPriceLabel
{
    if(!_allPriceLabel){
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5,SCREEN_WIDTH*0.3, 30)];
        _allPriceLabel.textColor = [UIColor blackColor];
        _allPriceLabel.text = @"合计：￥-";
        _allPriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _allPriceLabel;
}



#pragma mark ---- netwotk
-(void)requestData
{

    for (int i = 0; i<3; i++)
    {
        HCMtalkShopingInfo *info = [[HCMtalkShopingInfo alloc]init];
        info.title = @"套餐A M-talk二维码标签10张优惠";
        info.price = @"9.9";
        info.discount = @"满一百减二十";
        [self.dataArr addObject:info];
    }
    
    [self.dataArr insertObject:self.data[@"info"] atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
