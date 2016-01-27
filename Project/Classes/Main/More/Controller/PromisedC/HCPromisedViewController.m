//
//  HCPromisedViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPromisedViewController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCAddPromiseViewController1.h"

#import "MJRefresh.h"

#import "HCPromisedAddCell.h"
#import "HCPromisedListAPI.h"
#import "HCPromisedListInfo.h"

@interface HCPromisedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView     *smallTableView;
@property(nonatomic,strong)NSMutableArray  *dataArr;
@property(nonatomic,strong)UIImageView     *bgImage;

@end

@implementation HCPromisedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    [self  setupBackItem];
    [self requestData];
    [self  createUI];
    [self  createTableView];
}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [ super viewWillAppear:animated];
//    [self requestData];
//    [self.smallTableView reloadData];
//}

#pragma mark--UITableViewDelegate

-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedAddCell  *cell = [HCPromisedAddCell customCellWithTable:tableView];
    cell.backgroundColor = [UIColor clearColor];
    HCPromisedListInfo *info =self.dataArr[indexPath.row];
    cell.title = info.name;
    
    cell.buttonH = self.smallTableView.frame.size.height/5;
    cell.block = ^(NSString  *buttonTitle)
    {
        if ([buttonTitle isEqualToString:@"+ 新增录入"])
        {  //跳转到添加界面
            HCAddPromiseViewController1  *addVC = [[HCAddPromiseViewController1 alloc]init];
            [self.navigationController pushViewController:addVC animated:YES];
        }
        else
        {
            //跳转到信息界面
            HCPromiseDetailViewController1 *detailVC = [[HCPromiseDetailViewController1 alloc]init];
            detailVC.data = @{@"ObjectId":info.ObjectId};
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.smallTableView.frame.size.height/4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

#pragma mark---private method

-(void)createUI
{
   //背景图片
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 270,360)];
    _bgImage.userInteractionEnabled = YES;
    _bgImage.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+45);
    _bgImage.image = [UIImage imageNamed:@"yihubaiying_Background.png"];
    [self.view addSubview:_bgImage];
    
    //顶部图片
    CGFloat  headerViewW = _bgImage.frame.size.width/3;
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerViewW , headerViewW)];
    CGFloat  headerViewY = _bgImage.frame.origin.y-20;
    headerView.center = CGPointMake(SCREEN_WIDTH/2, headerViewY);
    headerView.image = [UIImage imageNamed:@"yihubaiying_icon_m-talk logo_dis.png"];
    [self.view addSubview:headerView];
    
    // 两个图片
    UIImageView  *leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, -15, 30, 30)];
    leftIV.image = [UIImage imageNamed:@"yihubaiying_nail.png"];
    [_bgImage addSubview:leftIV];
    
    CGFloat  rightIVX = _bgImage.frame.size.width - 10-30;
    UIImageView   *rightIV = [[UIImageView alloc]initWithFrame:CGRectMake(rightIVX, -15, 30, 30)];
    rightIV.image = [UIImage imageNamed:@"yihubaiying_nail.png"];
    [_bgImage addSubview:rightIV];
}

-(void)createTableView
{
    self.smallTableView.backgroundColor = [UIColor clearColor];
    self.smallTableView.rowHeight = 50;
    self.smallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgImage addSubview:self.smallTableView];
}

#pragma mark ---Setter Or Getter

-(NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView *)smallTableView
{
    if (!_smallTableView)
    {
        CGFloat  StabX = self.bgImage.frame.size.width-40;
        CGFloat  StabH = self.bgImage.frame.size.height -  80;
        _smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 50, StabX, StabH) style:UITableViewStylePlain];
        _smallTableView.delegate = self;
        _smallTableView.dataSource = self;
      
        _smallTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _smallTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
          [_smallTableView.mj_header beginRefreshing];
    }
    _smallTableView.showsVerticalScrollIndicator = NO;
    return _smallTableView;
}

#pragma mark --- network

// 下拉刷新请求数据
-(void)requestData
{
    HCPromisedListAPI  *api = [[HCPromisedListAPI alloc]init];
    api.Start = 0;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSMutableArray *array) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            [self.dataArr removeAllObjects];
            self.dataArr = array;
            HCPromisedListInfo *info = [[HCPromisedListInfo alloc]init];
            info.name=@"+ 新增录入";
            [self.dataArr addObject:info];
            [self.smallTableView.mj_header endRefreshing];
            [self.smallTableView reloadData];

        }else
        {
           [self showHUDError:message];
        }
        }];
}

//上拉加载更多数据
-(void)requestMoreData
{
    HCPromisedListAPI  *api = [[HCPromisedListAPI alloc]init];
    [self.dataArr removeLastObject];
    HCPromisedListInfo *info = self.dataArr[self.dataArr.count-1];
    api.Start = [info.ObjectId intValue];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSMutableArray *array) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            [self.dataArr addObjectsFromArray:array];
            HCPromisedListInfo *info = [[HCPromisedListInfo alloc]init];
            info.name=@"+ 新增录入";
            [self.dataArr addObject:info];
            [self.smallTableView.mj_footer endRefreshing];
            [self.smallTableView reloadData];
        }
        else
        {
            [self showHUDError:message];
        }
        
    }];
}

@end
