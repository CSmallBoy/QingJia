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

@interface HCRescueCenterViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIView *searchBarView;

@end

@implementation HCRescueCenterViewController
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键词快速搜索内容";
    }
    return _searchBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"求助中心";
    [self requestHomeData];

    [self setupBackItem];

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
    info = self.dataSource[indexPath.section];
    NSURL *imageViewUrl = [NSURL URLWithString:info.headerImageStr];

    [cell.imageView sd_setImageWithURL:imageViewUrl placeholderImage:OrigIMG(@"Salve_mtalk")];
    cell.textLabel.text = info.newsTitle;
    cell.detailTextLabel.text = info.detailNews;
    
    return  cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}








-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.searchBarView;
    }
    else
    {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = CLEARCOLOR;
        return view;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCaseDetailViewController *caseDetailVC = [[HCCaseDetailViewController  alloc]init];
    
    HCRescueCenterInfo *info = self.dataSource[indexPath.row];
    caseDetailVC.urlStr = info.urlStr;
    [self.navigationController pushViewController:caseDetailVC animated:YES];
}

#pragma mark----Setter Or Getter

-(UIView *)searchBarView
{
    if (!_searchBarView) {
        _searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [_searchBarView addSubview:self.searchBar];
    }
    return _searchBarView;
}


#pragma mark - network

- (void)requestHomeData
{
    HCRescueCenterApi *api = [[HCRescueCenterApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

@end
