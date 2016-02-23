//
//  MyFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "MyFamilyViewController.h"
#import "HCaddRelativeViewController.h"
#import "HCEditingMyselfViewController.h"
//家庭管理
#import "FamilyManageViewController.h"
@interface MyFamilyViewController ()

@end

@implementation MyFamilyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的家族";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings"] style:UIBarButtonItemStyleDone target:self action:@selector(barButtonClick)];
    self.navigationItem.rightBarButtonItem = barButton;
    [self setupBackItem];
    [self makeUI];
}

- (void)makeUI{
    NSArray *arr = @[@"人物一",@"人物二"];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH*0.4*i, SCREEN_HEIGHT/3, SCREEN_WIDTH/5, SCREEN_HEIGHT/3);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(UIButton *)button
{
    UIViewController *vc;
    if ([button.currentTitle isEqualToString:@"人物一"])
    {
        vc = [[HCaddRelativeViewController alloc]init];
    }else{
        vc = [[HCEditingMyselfViewController alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)barButtonClick{
    FamilyManageViewController * vc = [[FamilyManageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
