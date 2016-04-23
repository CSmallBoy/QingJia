//
//  HCReadNotificationViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.


// 呼·应 --------- 我的收藏--------------

#import "HCSaveNotificationViewController.h"
#import "HCNotificationDetailViewController.h"
#import "HCButtonItem.h"


#import "HCNotiMySaveCell.h"
#import "HCMyNotificationCenterTableViewCell.h"

#import "HCNotificationCenterInfo.h"
#import "HCMySaveListApi.h"

#import "HCNewTagInfo.h"
#import "HCCancelSaveApi.h"

@interface HCSaveNotificationViewController ()<UISearchBarDelegate,SCSwipeTableViewCellDelegate>
{
    NSMutableArray *saveBtnArr;
}

@property (nonatomic,strong) NSMutableArray * results;
@property(nonatomic,strong)UISearchBar      *seatchBar;
@property (nonatomic,strong)UITableView     *resultTableView;
@property (nonatomic,strong)UIView          *resultView;
@end

@implementation HCSaveNotificationViewController
#define readNotificationID @"readNotificationID"

- (void)viewDidLoad
{
    // 呼·应 --------- 我的收藏--------------
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(30);
    self.tableView.tableHeaderView.backgroundColor = [UIColor yellowColor];
    [self.tableView.tableHeaderView addSubview:self.seatchBar];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"showSave" object:nil];
}

-(void)show
{
    [self requestData];
}

#pragma mark ---  SCSwipeTableViewCellDelegate

//点击 侧滑出来的button
- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath{

    if (tag == 0) {
//----------------------取消收藏返回404--------------------------------------
        
        
        HCNotificationCenterInfo *info = self.dataSource[indexpath.row];
        HCCancelSaveApi *api = [[HCCancelSaveApi alloc]init];
        api.callId = info.callId;
        
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
           
            if (requestStatus == HCRequestStatusSuccess) {
                [self showHUDText:@"取消收藏成功"];
                [self.dataSource removeObjectAtIndex:indexpath.row];
                [self.tableView reloadData];
                
            }
            
        }];
        
    }
    

    
}

- (void)cellOptionBtnWillShow{
    NSLog(@"cellOptionBtnWillShow");
}

- (void)cellOptionBtnWillHide{
    NSLog(@"cellOptionBtnWillHide");
}

- (void)cellOptionBtnDidShow{
    NSLog(@"cellOptionBtnDidShow");
}

- (void)cellOptionBtnDidHide{
    NSLog(@"cellOptionBtnDidHide");
}



#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {

        
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
        btn1.backgroundColor =  COLOR(247, 68, 76, 1);
        UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
        imageView1.image = IMG(@"一呼百应详情－delete");
        [btn1 addSubview:imageView1];
            
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
        btn2.backgroundColor = COLOR(49, 155, 225, 1);
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
        imageView2.image = IMG(@"一呼百应详情－account");
        [btn2 addSubview:imageView2];
        btn2.tag = 200;
        
        saveBtnArr = [[NSMutableArray alloc]initWithObjects:btn1,btn2,nil];
        
        
        static NSString *cellIdentifier = @"SaveCell";
        HCNotiMySaveCell *cell = (HCNotiMySaveCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
       
        if (cell == nil) {
            cell = [[HCNotiMySaveCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"SaveCell"
                                                      withBtns:saveBtnArr
                                                     tableView:self.tableView];
            cell.delegate = self;
            cell.isSaveCell = YES;
        }
        cell.info = self.dataSource[indexPath.row];
        return cell;

    }
    else
    {
        static NSString  *cellID = @"NormalCell";
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID  ];
           
        }
        HCNotificationCenterInfo *info = self.results[indexPath.row];
        
        cell.textLabel.text = info.trueName;
        cell.imageView.image = [UIImage imageNamed:@"label_Head-Portraits"];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary  *dic = @{@"isSave" : @(1)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ToNextController" object:nil userInfo:dic];
    
}

#pragma mark ---UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.dataSource.count;
    }
    else
    {
        return self.results.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark ---UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH- 60, 30);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-60, 0, 60, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.backgroundColor = COLOR(189, 189, 183, 1);
    [button addTarget:self action:@selector(canleButtonSave:) forControlEvents:UIControlEventTouchUpInside];
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
    for ( HCNotificationCenterInfo *info in self.dataSource)
    {
        NSRange  range = [info.trueName rangeOfString:searchText];
        if (range.location != NSNotFound) {
            [self.results addObject:info];
            
        }
    }
    [self.resultTableView reloadData];
    
    
}

#pragma mark ---- scrollViewdelegate
//搜索结果的tableView在开始滚动的时候收起键盘
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark --- buttonClick
-(void)canleButtonSave:(UIButton  *)button
{
    self.seatchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self.tableView.tableHeaderView bringSubviewToFront: self.seatchBar];
    self.seatchBar.text = nil;
    [self.resultTableView removeFromSuperview];
    [self.resultView removeFromSuperview];
    [self.seatchBar endEditing:YES];
}


#pragma mark --- getter Or setter


- (UISearchBar *)seatchBar
{
    if(!_seatchBar){
        _seatchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
        _seatchBar.placeholder = @"请输入关键词快速搜索";
        _seatchBar.delegate = self;
    }
    return _seatchBar;
}


- (NSMutableArray *)results
{
    if(!_results){
        _results = [[NSMutableArray alloc]init];
    }
    return _results;
}

//
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


- (UIView *)resultView
{
    if(!_resultView){
        _resultView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-144)];
        _resultView.backgroundColor =[UIColor blackColor];
        _resultView.alpha = 0.2;
        UITapGestureRecognizer  *Tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(canleButtonSave:)];
        [_resultView addGestureRecognizer:Tap];
    }
    return _resultView;
}



#pragma mark - network


- (void)requestData
{
    HCMySaveListApi *api = [[HCMySaveListApi alloc]init];
    
    api.key = @"";
    api._start = @"0";
    api._count = @"20";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            
            [self.dataSource removeAllObjects];
            
            NSArray *array = respone[@"Data"][@"rows"];
            
            for (NSDictionary *dic in array) {
               
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic ];
                [self.dataSource addObject:info];
            }
            
            [self.tableView reloadData];
            NSLog(@"----------------我的收藏列表获取成功------------");
        }
        
    }];


}
@end
