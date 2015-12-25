//
//  HCMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCMessageViewController.h"
#import "HCMessageListViewController.h"
#import "HCContactsViewController.h"

@interface HCMessageViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) HCMessageListViewController *messageListVC;
@property (nonatomic, strong) HCContactsViewController *contactsVC;

@end

@implementation HCMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segmentedControl;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.view addSubview:self.mainView];
    [self handleSegmentedControl:self.segmentedControl];
}

#pragma mark - private methods

- (void)handleRightItem
{
    DLog(@"添加好友");
}

- (void)handleSegmentedControl:(UISegmentedControl *)segmentedControl
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    [self.mainView setContentOffset:CGPointMake(index * WIDTH(self.view), 0) animated:YES];
    if (index == 0)
    {
        [self.mainView addSubview:self.messageListVC.view];
    }else if (index == 1)
    {
        [self.mainView addSubview:self.contactsVC.view];
    }
}

#pragma mark - setter or getter

- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl)
    {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@" 消息 ", @" 联系人 "]];
        [_segmentedControl addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

- (UIScrollView *)mainView
{
    if (!_mainView)
    {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH(self.view), HEIGHT(self.view))];
        _mainView.contentSize = CGSizeMake(WIDTH(self.view) * 2, 0);
        _mainView.pagingEnabled = YES;
        _mainView.scrollEnabled = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
    }
    return _mainView;
}


- (HCMessageListViewController *)messageListVC
{
    if (!_messageListVC)
    {
        _messageListVC = [[HCMessageListViewController alloc] init];
        _messageListVC.view.frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-104);
        [self addChildViewController:_messageListVC];
    }
    return _messageListVC;
}

- (HCContactsViewController *)contactsVC
{
    if (!_contactsVC)
    {
        _contactsVC = [[HCContactsViewController alloc] init];
        _contactsVC.view.frame = CGRectMake(WIDTH(self.view), 0, WIDTH(self.view), HEIGHT(self.view)-64);
        [self addChildViewController:_contactsVC];
    }
    return _contactsVC;
}


@end
