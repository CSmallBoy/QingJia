//
//  HCPromisedTagMangerViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//


#import "HCTagUserMangerViewController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCAddTagUserController.h"
#import "HCTagUserDetailController.h"
#import "HCTagUserCell.h"

#import "HCNewTagInfo.h"

#import "HCObjectListApi.h"
#import "HCTagUserAmostListApi.h"
#import "HCTagDeleteObjectApi.h"

@interface HCTagUserMangerViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SCSwipeTableViewCellDelegate>

@property (nonatomic,strong) UITableView  *myTableView;
@property (nonatomic,strong) NSMutableArray   *dataArr;
@property (nonatomic,strong) HCNewTagInfo *deleteInfo;
@property (nonatomic,strong) NSArray *btnArr;

@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCTagUserMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"标签试用者管理";
    [self  setupBackItem];

    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuTagUserDetailVC:) name:@"tuTagUserDetailVC" object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark ---UITableViewDelegate,UITableViewDataSoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
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
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
    btn1.backgroundColor = COLOR(247, 68, 76, 1);
    UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
    imageView1.image = IMG(@"一呼百应详情－delete");
    [btn1 addSubview:imageView1];
    btn1.tag = 100;
    _btnArr = @[btn1];
    
    static NSString *cellIdentitier = @"HCTagUserCell";
    HCTagUserCell *cell = (HCTagUserCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentitier];
    if (cell == nil) {
        cell = [[HCTagUserCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentitier
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

    HCNewTagInfo *info = self.dataArr[indexpath.row];
    self.deleteInfo = info;
    
    HCTagDeleteObjectApi *api = [[HCTagDeleteObjectApi alloc]init];
    api.objectId = self.deleteInfo.objectId;
    
    [api startRequest:^(HCRequestStatus requestStaus, NSString *message, id respone) {
        
        if (requestStaus == HCRequestStatusSuccess)
        {
            [self.dataArr removeObject:self.deleteInfo];
            [self.myTableView reloadData];
        }
        else
        {
            NSString *str = respone[@"message"];
            [self showHUDSuccess:str];
        }
        
    }];

    
}


#pragma mark --- private mothods

// 点击了新增标签使用者
-(void)rightItemClick:(UIBarButtonItem *)item

{

    HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
    HCAddTagUserController *detailVC = [[HCAddTagUserController alloc]init];
    detailVC.data = @{@"info":info};
    [self.navigationController pushViewController:detailVC animated:YES];
   
}

-(void)longPress:(UILongPressGestureRecognizer *)longP
{
    
    if (longP.state == UIGestureRecognizerStateBegan) {
        HCTagUserCell *cell = (HCTagUserCell *)longP.view;
        self.deleteInfo = cell.info;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除此标签使用者" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    
    }
    

}

-(void)tuTagUserDetailVC:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    HCNewTagInfo *info = dic[@"info"];

    HCTagUserDetailController *vc = [[HCTagUserDetailController alloc]init];
    vc.data = @{@"info":info};
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark --- getter Or setter


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


-(NSMutableArray *)dataArr
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
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 10, SCREEN_WIDTH-60, 30);
        ViewRadius(button, 5);
        button.backgroundColor = kHCNavBarColor;
        [button setTitle:@"+新增标签使用者" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
    }
    return _footerView;
}


#pragma mark --- network

-(void)requestData
{
    HCTagUserAmostListApi *api = [[HCTagUserAmostListApi alloc]init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataArr removeAllObjects];
             NSArray *array = respone [@"Data"][@"rows"];
            
            for (NSDictionary *dic in array)
            {
            HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
            [self.dataArr addObject:info];
            [self.myTableView reloadData];
             }
            
        }
       else
       {
            [self showHUDError:@"请求数据失败"];
        }

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
