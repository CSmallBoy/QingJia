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
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation HCAddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加指定好友";
    [self setupBackItem];
    self.view.backgroundColor = RGB(230, 230, 230);
    self.navigationItem.rightBarButtonItem = self.rightItem;
    [self.view addSubview:self.searchTextField];
}

#pragma mark - UITableView

#pragma mark - private methods

- (void)handleRightItem
{
    if (IsEmpty(self.searchTextField.text))
    {
        [self showHUDText:@"请输入正确的ID号"];
        return;
    }
    [self requestAddFriend];
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

- (UITextField *)searchTextField
{
    if (!_searchTextField)
    {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, WIDTH(self.view)-20, 45)];
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.placeholder = @"输入好友ID号";
        ViewBorderRadius(_searchTextField, 0, 1, RGB(220, 220, 220));
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 45)];
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchTextField;
}

#pragma mark - network 

- (void)requestAddFriend
{
    DLog(@"添加好友请求");
}


@end
