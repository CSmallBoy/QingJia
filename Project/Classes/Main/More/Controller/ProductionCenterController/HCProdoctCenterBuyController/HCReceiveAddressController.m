//
//  HCReceiveAddressController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReceiveAddressController.h"
#import "HCAddNewAddressViewController.h"
#import "HCEditAddressViewController.h"

#import "HCAddressInfo.h"

#import "HCReceiveAddressCell.h"

@interface HCReceiveAddressController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView  *mytableView;
@property (nonatomic,strong) NSMutableArray  *dataArr;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCReceiveAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    //------------------收货地址--------------------------------
    self.title = @"收货地址";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    [self requestData];
    [self.view addSubview:self.mytableView];
    [self.view addSubview:self.footerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toEditVC:) name:@"toEditVC" object:nil];
    
 
}
#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCReceiveAddressCell *cell = [HCReceiveAddressCell cellWithTableView:tableView];
    cell.info = self.dataArr[indexPath.section];
    cell.indexpath = indexPath;
    cell.block=^(NSIndexPath *index){
   
    
        for (NSInteger i = 0; i<self.dataArr.count; i++) {
            HCAddressInfo *info = self.dataArr[i];
            if (i== index.section) {
                
                info.isDefault = YES;
            }
            else
            {
                info.isDefault = NO;
            }
        }
    
        [self.mytableView reloadData];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

#pragma mark --- provate mothods

-(void)toAddAddressVC:(UIButton *)button
{
    HCAddNewAddressViewController *newAddVC = [[HCAddNewAddressViewController alloc]init];
    [self.navigationController pushViewController:newAddVC animated:YES];

}


-(void)toEditVC:(NSNotification *)noti
{
    
    
    HCEditAddressViewController *editVC = [[HCEditAddressViewController alloc]init];
    NSIndexPath *indexPath = noti.userInfo[@"index"];
    
    editVC.data = @{@"info":self.dataArr[indexPath.section]};
    
    [self.navigationController pushViewController:editVC animated:YES];


}

#pragma mark --- getter Or setter


- (UITableView *)mytableView
{
    if(!_mytableView){
        _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        
        _mytableView.backgroundColor = kHCBackgroundColor;
        
    }
    return _mytableView;
}


- (NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = kHCBackgroundColor;
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 40);
        [button setTitle:@"+新增地址" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = kHCNavBarColor;
        [button addTarget:self action:@selector(toAddAddressVC:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
    }
    return _footerView;
}



#pragma mark --- netWork

-(void)requestData
{

    for (int i = 0; i<3; i++)
    {
        HCAddressInfo *info = [[HCAddressInfo alloc]init];
        if (i == 0) {
            info.isDefault = YES;
        }
        info.consigneeName = [NSString stringWithFormat:@"Tom%d",i];
        info.phoneNumb = @"18317160680";
        info.postcode = @"200000";
        info.receivingCity = @"上海市闵行区";
        info.receivingStreet = @"集心路168号1号楼502";
        
        [self.dataArr addObject:info];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
