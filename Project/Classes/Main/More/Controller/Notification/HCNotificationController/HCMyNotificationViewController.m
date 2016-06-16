//
//  HCUnReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.

//  呼·应---------与我相关--------

#import "HCMyNotificationViewController.h"
#import "HCNotificationDetailViewController.h"


#import "HCButtonItem.h"
#import "MJRefresh.h"

#import "HCMyNotificationCenterTableViewCell.h"
#import "HCNotifcationMessageCell.h"
#import "HCNotificationMessageCallCell.h"

#import "HCNewTagInfo.h"

#import "HCNotificationCenterInfo.h"
#import "HCNotifcationMessageInfo.h"

#import "HCAboutMeApi.h"

#import "HCMyPromisedNotifiMessageCell.h"
#import "HCDeletePromisedApi.h"
//发现线索
#import "HCPromisedCommentController.h"

@interface HCMyNotificationViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource,SCSwipeTableViewCellDelegate>

@property (nonatomic,strong)UITableView     *resultTableView;
@property (nonatomic,strong) UISearchBar     *seatchBar;
@property (nonatomic,strong)NSMutableArray   *resultMes;
@property (nonatomic,strong)NSMutableArray   *resultOthers;
@property (nonatomic,strong) NSMutableArray  *messageArr;
@property (nonatomic,strong)UIView          *resultView;

@property (nonatomic,strong) UITableView    *myTableView;
@property (nonatomic,strong) NSMutableArray  *dataSource;

@property (nonatomic,strong) NSString *start;

@end

@implementation HCMyNotificationViewController

- (void)viewDidLoad
{
    //  呼·应---------与我相关--------
    [super viewDidLoad];
    self.myTableView.tableHeaderView = HCTabelHeadView(30);
    [self.myTableView.tableHeaderView addSubview:self.seatchBar];
    [self requestData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"show" object:nil];
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    self.view.backgroundColor = kHCBackgroundColor;

    self.start = @"0";
    
    //发呼成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"callPromised" object:nil];
}

#pragma mark ---  SCSwipeTableViewCellDelegate

//点击 侧滑出来的button
- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath{
    //删除
    if (tag == 0)
    {
        HCNotificationCenterInfo *info = self.dataSource[indexpath.row];
        HCDeletePromisedApi *api =[[HCDeletePromisedApi alloc]init];
        api.callId = info.callId;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
            if (requestStatus == HCRequestStatusSuccess) {
                //删除成功相当于关闭呼
                [self showHUDText:@"删除成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"delectCallSuccess" object:nil];
                [self requestData];
            }
            else
            {
                [self showHUDText:respone[@"message"]];
            }
            
        }];
    }
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.myTableView)
    {
        if (indexPath.section == 0 ) {// 自己发出去的“呼”cell
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
            btn1.backgroundColor = COLOR(247, 68, 76, 1);
            UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
            imageView1.image = IMG(@"一呼百应详情－delete");
            [btn1 addSubview:imageView1];
            btn1.tag = 100;
            
            NSArray *btnArr = @[btn1];
            
            static NSString *cellIdentifier = @"myPromisedCell";
            HCMyPromisedNotifiMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[HCMyPromisedNotifiMessageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:cellIdentifier
                                                               withBtns:btnArr
                                                              tableView:self.myTableView];
                cell.delegate = self;
            }
            cell.info = self.dataSource[indexPath.row];
            return cell;
        }
        else
        {
            HCNewTagInfo *messInfo = self.messageArr[indexPath.row];
            HCNotifcationMessageCell  *cell = [HCNotifcationMessageCell cellWithTableView:tableView];
            cell.messageInfo = messInfo;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else
    {
        static NSString  *cellID = @"MineNormalCell";
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID  ];
            
        }
        HCNotificationCenterInfo *info;
        if (indexPath.section == 0) {
           info = self.resultMes[indexPath.row];
        }else
        {
            info = self.resultOthers[indexPath.row];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 200, 40)];
        label.textColor = [UIColor blackColor];
        label.text = info.lossDesciption;
        [cell.contentView addSubview:label];
        
        
        UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        NSURL  *url = [readUserInfo originUrl:info.imageName :kkObject];
        [headIV sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
        
        [cell.contentView addSubview:headIV];
        return cell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
         return 40;
    }
    
    return 40;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.backgroundColor = kHCBackgroundColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    if (section == 0)
    {
        label.text = @"  已发出的呼应";
    }
    else
    {
        label.text = @"  已提供的线索";
    }
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.myTableView)
    {
        return 2;
    }else
    {
        return 2;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.myTableView)
    {
        if (section == 0)
        {
            return self.dataSource.count;
        }
        else
        {
            return self.messageArr.count;
            
        }
    }
    else
    {
    
        if (section == 0)
        {
            return self.resultMes.count;
        }
        else
        {
            return self.resultOthers.count;
            
        }
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0 && tableView == self.myTableView)
    {
        HCNotificationCenterInfo *info = self.dataSource[indexPath.row];
      NSDictionary *dic = @{@"info" : info.callId,@"status":info.status};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"ToNextMyController" object:nil userInfo:dic];
    }
    if (indexPath.section == 1 && tableView == self.myTableView)
    {
        HCNewTagInfo *messInfo = self.messageArr[indexPath.row];
        HCPromisedCommentController *commentVC = [[HCPromisedCommentController alloc] init];
        commentVC.callId = messInfo.callId;
        commentVC.hidesBottomBarWhenPushed = YES;
        [self.parentViewController.navigationController pushViewController:commentVC animated:YES];
    }

}

#pragma mark ---UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH- 60, 30);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-60, 0, 60, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.backgroundColor = COLOR(189, 189, 183, 1);
    [button addTarget:self action:@selector(canleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTableView.tableHeaderView addSubview:button];
    
    [self.view addSubview:self.resultView];
    
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    self.resultTableView.frame= CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144-49);
    NSLog(@"%@",searchText);
    if (searchText.length != 0)
    {
        [self.view addSubview:self.resultTableView];
    }
    else
    {
        [self.resultTableView removeFromSuperview];
    }

    [self requestSearchData];
}


#pragma mark --- scrollerViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark --- private mothods

-(void)canleButton:(UIButton  *)button
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self.myTableView.tableHeaderView bringSubviewToFront: self.seatchBar];
    self.seatchBar.text = nil;
    [self.resultTableView removeFromSuperview];
    [self.resultView removeFromSuperview];
    [self.seatchBar endEditing:YES];
}


#pragma mark --- provite mothods

-(void)show
{
    [self requestData];
}


#pragma mark --- getter Or setter


- (NSMutableArray *)resultMes
{
    if(!_resultMes){
        _resultMes = [NSMutableArray array];
    }
    return _resultMes;
}


- (NSMutableArray *)resultOthers
{
    if(!_resultOthers){
        _resultOthers = [NSMutableArray array];
    }
    return _resultOthers;
}

- (NSMutableArray *)messageArr
{
    if(!_messageArr){
        _messageArr = [[NSMutableArray alloc]init];
    }
    return _messageArr;
}


- (UISearchBar *)seatchBar
{
    if(!_seatchBar){
        _seatchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
        _seatchBar.placeholder = @"请输入关键词快速搜索";
        _seatchBar.delegate = self;
    }
    return _seatchBar;
}

- (UIView *)resultView
{
    if(!_resultView){
        _resultView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144)];
        _resultView.backgroundColor =[UIColor blackColor];
        _resultView.alpha = 0.2;
        UITapGestureRecognizer  *Tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(canleButton:)];
        [_resultView addGestureRecognizer:Tap];
    }
    return _resultView;
}

- (UITableView *)resultTableView
{
    if(!_resultTableView){
        _resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144) style:UITableViewStylePlain];
        _resultTableView.backgroundColor = [UIColor whiteColor];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
    }
    return _resultTableView;
}

- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114-44) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = kHCBackgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


- (NSMutableArray *)dataSource
{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - network

- (void)requestData
{
    HCAboutMeApi *api = [[HCAboutMeApi alloc]init];
    api.key = @"";
    api._start = @"0";
    api._count = @"20";
//    [[HCDetectNetworkStatusMgr shareManager] detectNetworkStatus:^(AFNetworkReachabilityStatus networkStatus) {
//        if (networkStatus == AFNetworkReachabilityStatusNotReachable)//没有网络的情况下
//        {
            if ([api cacheJson])//如果有缓存就使用缓存
            {
                [self.dataSource removeAllObjects];
                NSArray *array1 = [api cacheJson][@"Data"][@"rows1"];
                for (NSDictionary *dic in array1) {
                    HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                    [self.dataSource addObject:info];
                }
                [self.messageArr removeAllObjects];
                NSArray *array2 = [api cacheJson][@"Data"][@"rows2"];
                for (NSDictionary *dic in array2) {
                    HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                    [self.messageArr addObject:info];
                }
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
            }
            else//如果没有缓存,给出无网络的提示
            {
                
            }

//        }
//    }];

    
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone)
    {
        if (requestStatus == HCRequestStatusSuccess) {
            [self.dataSource removeAllObjects];
            NSArray *array1 = respone[@"Data"][@"rows1"];
            for (NSDictionary *dic in array1) {
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.dataSource addObject:info];
            }
            [self.messageArr removeAllObjects];
            NSArray *array2 = respone[@"Data"][@"rows2"];
            for (NSDictionary *dic in array2) {
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.messageArr addObject:info];
            }
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView reloadData];
            NSLog(@"--------------与我相关列表获取成功------------");
        }
        
    }];
    
//    HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc]init];
//    
//    [self.dataSource addObject:info];
}

-(void)requestMoreData
{
    HCAboutMeApi *api = [[HCAboutMeApi alloc]init];
    api.key = @"";
    
    int  num = [self.start intValue];
    num = num +20;
    self.start = [NSString stringWithFormat:@"%d",num];
    api._start = self.start;
    api._count = @"20";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
        
            
            NSArray *array2 = respone[@"Data"][@"rows2"];
            
            for (NSDictionary *dic in array2) {
                
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.messageArr addObject:info];
                
            }
            
            [self.myTableView.mj_footer endRefreshing];
            [self.myTableView reloadData];
            
            NSLog(@"--------------与我相关列表获取成功------------");
        }
    }];
}


-(void)requestSearchData
{
    HCAboutMeApi *api = [[HCAboutMeApi alloc]init];
    api.key = self.seatchBar.text;
    api._start = @"0";
    api._count = @"20";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
        
            [self.resultMes removeAllObjects];
            [self.resultOthers removeAllObjects];
            
            NSArray *array1 = respone[@"Data"][@"rows1"];
            
            for (NSDictionary *dic in array1) {
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.resultMes addObject:info];
            }
            
            NSArray *array2 = respone[@"Data"][@"rows2"];
            for (NSDictionary *dic in array2) {
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.resultOthers addObject:info];
            }

            [self.resultTableView reloadData];
            
            NSLog(@"--------------搜索------------");
        }
    }];
}

@end
