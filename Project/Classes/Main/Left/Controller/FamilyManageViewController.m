//
//  FamilyManageViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "FamilyManageViewController.h"
#import "HCInviteFamilyViewController.h"
#import "HCLikeFamilyViewController.h"
#import "HCCombineFamilyViewController.h"
@interface FamilyManageViewController ()

@end

@implementation FamilyManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭管理";
    UIBarButtonItem *barButton= [[UIBarButtonItem alloc]initWithTitle:@"审核" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonClick)];
    self.navigationItem.rightBarButtonItem = barButton;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    [self makeUI];
}
//审核事件
- (void)barButtonClick{
    
}
- (void)makeUI{
    UIImageView *back_image = [[UIImageView alloc]initWithFrame:self.view.frame];
    back_image.image = [UIImage imageNamed:@"jia.jpg"];
    back_image.userInteractionEnabled = YES;
    [self.view addSubview:back_image];
    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.alpha = 0.8;
    [back_image addSubview:view];
    NSArray *arr = @[@"邀请家庭加入",@"合并家庭记录",@"可能属于的家庭",@"合并家庭管理"];
    for (int i = 0 ; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.3+SCREEN_HEIGHT* 0.12*i, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.08);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.alpha = 0.8;
        button.tag = 2000+i;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}
- (void)buttonClick:(UIButton *)button{
    UIViewController *vc;
    switch (button.tag) {
        case 2000:
        {//邀请家庭加入
            vc = [[HCInviteFamilyViewController alloc]init];
            
        }
            break;
        case 2001:
        {//合并家庭记录
            
        }
            break;
        case 2002:
        {//可能属于的家庭
            vc = [[HCLikeFamilyViewController alloc]init];
        }
            break;
        case 2003:
        {//合并家庭的管理
            vc = [[HCCombineFamilyViewController alloc]init];
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
