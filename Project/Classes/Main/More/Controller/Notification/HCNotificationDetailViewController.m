//
//  HCNotificationDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationDetailViewController.h"

@interface HCNotificationDetailViewController ()

@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *notificationMessLab;

@end

@implementation HCNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息详情";
    
    
}



-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2-10, 44)];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.text = @"信息详情";
    }
    return _userNameLab;
}


@end
