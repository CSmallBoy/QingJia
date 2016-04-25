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

#import "HCMyNotificationCenterTableViewCell.h"
#import "HCNotifcationMessageCell.h"
#import "HCNotificationMessageCallCell.h"

#import "HCNewTagInfo.h"

#import "HCNotificationCenterInfo.h"
#import "HCNotifcationMessageInfo.h"

#import "HCAboutMeApi.h"

@interface HCMyNotificationViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,UISearchControllerDelegate>

@property (nonatomic,strong)UITableView     *resultTableView;
@property (nonatomic,strong) UISearchBar     *seatchBar;
@property (nonatomic,strong)NSMutableArray   *results;
@property (nonatomic,strong) NSMutableArray  *messageArr;
@property (nonatomic,strong)UIView          *resultView;
@end

@implementation HCMyNotificationViewController

- (void)viewDidLoad
{
    //  呼·应---------与我相关--------
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(30);
    self.tableView.tableHeaderView.backgroundColor = [UIColor yellowColor];
    [self.tableView.tableHeaderView addSubview:self.seatchBar];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"show" object:nil];

}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView) {
        
        if (indexPath.section == 0 ) {// 自己发出去的“呼”cell
            HCMyNotificationCenterTableViewCell *cell = [HCMyNotificationCenterTableViewCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.info = self.dataSource[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
  
    return nil;

    
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
         return 1;
    }
    
    return 10;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return 2;
    }else
    {
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.tableView)
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
    
        return self.results.count;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0 && tableView == self.tableView)
    {
      NSDictionary *dic = @{@"info" : self.dataSource[indexPath.row]};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"ToNextMyController" object:nil userInfo:dic];
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
    [self.tableView.tableHeaderView addSubview:button];
    
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
    
    [self.results removeAllObjects];
    for ( HCNotifcationMessageInfo *info in self.messageArr) {
        
        NSRange  range = [info.message rangeOfString:searchText];
        NSLog(@"%@",info.message);
        if (range.location != NSNotFound)
        {
            [self.results addObject:info];
            
        }
    }
    
    for (HCNotifcationMessageInfo *info in self.results) {
        
        if (info.message == nil) {
            
            [self.results removeObject:info];
        }
    }
    
    [self.resultTableView reloadData];

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
    [self.tableView.tableHeaderView bringSubviewToFront: self.seatchBar];
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


- (NSMutableArray *)results
{
    if(!_results){
        _results = [NSMutableArray array];
    }
    return _results;
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



#pragma mark - network

- (void)requestData
{
    

    HCAboutMeApi *api = [[HCAboutMeApi alloc]init];
    api.key = @"";
    api._start = @"0";
    api._count = @"20";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            
            [self.dataSource removeAllObjects];
            
            NSArray *array1 = respone[@"Data"][@"rows1"];
            
            for (NSDictionary *dic in array1) {
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.dataSource addObject:info];
            }
            
            NSArray *array2 = respone[@"Data"][@"rows2"];
            
            for (NSDictionary *dic in array2) {
                
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                [self.messageArr addObject:info];
                
            }
            
            [self.tableView reloadData];
            
            NSLog(@"--------------与我相关列表获取成功------------");
            
        }
        
    }];
    
    HCNotificationCenterInfo *info = [[HCNotificationCenterInfo alloc]init];
    
    [self.dataSource addObject:info];
    

}

@end
