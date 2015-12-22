//
//  HCAddFriendViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCAddFriendViewController.h"

@interface HCAddFriendViewController ()

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation HCAddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加制定好友";
    [self setupBackItem];
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

#pragma mark - UITableView

#pragma mark - private methods

- (void)handleRightItem
{
    DLog(@"添加");
}

#pragma mark - setter or setter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

@end
