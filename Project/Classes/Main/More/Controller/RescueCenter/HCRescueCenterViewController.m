//
//  HCRescueCenterViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRescueCenterViewController.h"
#import "HCCaseDetailViewController.h"
#import "HCRescueCenterApi.h"
#import "HCRescueCenterInfo.h"
#import "UIImageView+WebCache.h"

@interface HCRescueCenterViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,UISearchControllerDelegate>

//定义一个可变数组，存放搜索结果
@property(nonatomic,strong) NSMutableArray *results;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic,strong) UISearchBar *searchBar ;

@end

@implementation HCRescueCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.searchBar;
    self.title = @"求助中心";
    [self requestHomeData];
    [self setupBackItem];
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchCell"];
    
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rescueID = @"rescueCenter";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rescueID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rescueID];
    }
    
    HCRescueCenterInfo *info ;
    if (tableView == self.tableView)
    {
        info = self.dataSource[indexPath.section];
    }else{
        info = self.results[indexPath.section];
    }
    NSURL *imageViewUrl = [NSURL URLWithString:info.headerImageStr];
    
    [cell.imageView sd_setImageWithURL:imageViewUrl placeholderImage:OrigIMG(@"Salve_mtalk")];
    cell.textLabel.text = info.CTitle;
    cell.detailTextLabel.text = info.ActTime;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCaseDetailViewController *caseDetailVC = [[HCCaseDetailViewController  alloc]init];
    [self.navigationController pushViewController:caseDetailVC animated:YES];
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return self.results.count;
    }else
    {
        return self.dataSource.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

#pragma mark----UISearchDisplayControllerDelegate

//只要在搜索框中修改搜索的内容，立即调用此方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.results removeAllObjects];
    for (HCRescueCenterInfo *info in self.dataSource)
    {
        NSRange range = [info.CTitle rangeOfString:searchString];
        if (range.location != NSNotFound )
        {
            [self.results addObject:info];
        }
    }
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //获取此时搜索框中的文本
    NSString *searhText = self.searchDisplayController.searchBar.text;
    [self.results removeAllObjects];
    for (HCRescueCenterInfo *info in self.dataSource)
    {
        NSRange range = [info.CTitle rangeOfString:searhText];
        if (range.location != NSNotFound )
        {
            [self.results addObject:info];
        }
    }
    return YES;
}

#pragma mark----Setter Or Getter

-(UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}

-(UISearchDisplayController *)searchDisplayController
{
    if (!_searchDisplayController)
    {
        _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDelegate = self;
        _searchDisplayController.searchResultsDataSource = self;
    }
    return _searchDisplayController;
}

- (NSMutableArray *)results
{
    if (!_results)
    {
        _results = [NSMutableArray new];
    }
    return _results;
}

#pragma mark - network

- (void)requestHomeData
{
    HCRescueCenterApi *api = [[HCRescueCenterApi alloc] init];
    
    api.Start = 1000;
    api.Count = 20;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array)
     {
         if (requestStatus == HCRequestStatusSuccess)
         {
             [self.dataSource removeAllObjects];
             [self.dataSource addObjectsFromArray:array];
             [self.tableView reloadData];
         }else
         {
             [self.dataSource removeAllObjects];
             [self.dataSource addObjectsFromArray:array];
             [self.tableView reloadData];
             [self showHUDError:message];
         }
     }];
}

@end
