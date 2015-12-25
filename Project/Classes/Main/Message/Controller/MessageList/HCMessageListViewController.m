//
//  HCMessageListViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCMessageListViewController.h"

@interface HCMessageListViewController ()

@end

@implementation HCMessageListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = @"测试对方";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


@end
