//
//  HCJurisdictionViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
// 默认权限设置

#import "HCJurisdictionViewController.h"

@interface HCJurisdictionViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, assign) NSInteger selected;

@end

@implementation HCJurisdictionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"权限设置";
    [self setupBackItem];
    
    _selected = 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jurisdiction"];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    if (_selected == indexPath.row)
    {
        cell.imageView.image = OrigIMG(@"select");
    }else
    {
        cell.imageView.image = OrigIMG(@"left_white");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selected = indexPath.row;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"仅好友可见", @"所有人可见", @"仅自己可见", @"指定好友不可见"];
    }
    return _titleArr;
}



@end
