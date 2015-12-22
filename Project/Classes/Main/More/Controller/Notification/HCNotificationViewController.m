//
//  HCNotificationViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationViewController.h"
#import "HCUnReadNotificationViewController.h"
#import "HCReadNotificationViewController.h"
#import "HCFollowNotificationViewController.h"
@interface HCNotificationViewController ()
@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) HCUnReadNotificationViewController *unreadVC;
@property (nonatomic,strong) HCReadNotificationViewController *readVC;
@property (nonatomic,strong) HCFollowNotificationViewController *followVC;
@end

@implementation HCNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通知中心";
    [self.view addSubview:self.unreadVC.view];
    [self.view addSubview:self.segmented];
    [self setupBackItem];
    
}




- (void)handleSegmentedControl:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        [self.unreadVC.view removeFromSuperview];
        [self.view addSubview:self.unreadVC.view];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        [self.readVC.view removeFromSuperview];
        [self.view addSubview:self.readVC.view];
    }else if (segment.selectedSegmentIndex == 2)
    {
        [self.followVC.view removeFromSuperview];
        [self.view addSubview:self.followVC.view];
    }
}

-(UISegmentedControl *)segmented
{
        if (!_segmented)
        {
            _segmented = [[UISegmentedControl alloc] initWithItems:@[@"未读信息", @"已读信息",@"跟进信息"]];
            _segmented.selectedSegmentIndex = 0;
            _segmented.frame = CGRectMake(20, 84, SCREEN_WIDTH-40, 30);
            _segmented.backgroundColor = [UIColor whiteColor];
            _segmented.tintColor = [UIColor redColor];
            [_segmented addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
        }
        return _segmented;
}

-(HCUnReadNotificationViewController *)unreadVC
{
    if (!_unreadVC) {
        _unreadVC = [[HCUnReadNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _unreadVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT);
        [self addChildViewController:_unreadVC];
    }
    return _unreadVC;
}

-(HCReadNotificationViewController *)readVC
{
    if (!_readVC) {
        _readVC = [[HCReadNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _readVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT);
        [self addChildViewController:_readVC];
    }
    return _readVC;
}

-(HCFollowNotificationViewController *)followVC
{
    if (!_followVC) {
        _followVC = [[HCFollowNotificationViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _followVC.view.frame = CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT);
        [self addChildViewController:_followVC];
    }
    return _followVC;
}


@end
