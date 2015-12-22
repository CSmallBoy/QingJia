//
//  HCRescueCenterViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRescueCenterViewController.h"
#import "HCCaseDetailViewController.h"
@interface HCRescueCenterViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation HCRescueCenterViewController
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键词快速搜索内容";
    }
    return _searchBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"求助中心";
    [self.view addSubview:self.searchBar];
    [self setupBackItem];
    self.tableView.frame = CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT);
}


#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rescueID = @"rescueCenter";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rescueID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rescueID];
    }
    cell.imageView.image = OrigIMG(@"Notice");
    cell.textLabel.text = @"M-Talk1244535";
    cell.detailTextLabel.text = @"时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。。";
//    cell.detailTextLabel.numberOfLines = 0;
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCaseDetailViewController *caseDetailVC = [[HCCaseDetailViewController  alloc]init];
    [self.navigationController pushViewController:caseDetailVC animated:YES];
}

@end
