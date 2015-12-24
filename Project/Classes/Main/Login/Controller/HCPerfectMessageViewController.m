//
//  HCPerfectMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPerfectMessageViewController.h"
#import "HCGradeViewController.h"

@interface HCPerfectMessageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (weak, nonatomic) IBOutlet UIButton *menBtn;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;



@end

@implementation HCPerfectMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"完善信息";
    [self setupBackItem];
    _menBtn.selected = YES;
    ViewRadius(_registerBtn, 4);
}
- (IBAction)selectedSexButton:(UIButton *)sender
{
    if (sender.tag)
    {
        _womenBtn.selected = YES;
        _menBtn.selected = NO;
    }else
    {
        _womenBtn.selected = NO;
        _menBtn.selected = YES;
    }
}
- (IBAction)registerButton:(UIButton *)sender
{
//    if (IsEmpty(_nameTextField.text))
//    {
//        [self showHUDText:@"请输入姓名"];
//        return;
//    }
//    if (IsEmpty(_password.text) || IsEmpty(_repassword.text))
//    {
//        [self showHUDText:@"请输入密码"];
//        return;
//    }
//    if ([_password.text isEqualToString:_repassword.text])
//    {
//        [self showHUDText:@"输入的密码不一致"];
//        return;
//    }
    [self requestPerfectMessage];
}

// 服务协议
- (IBAction)serverButton:(UIButton *)sender
{
    [self showHUDText:@"服务协议"];
}

// 隐私政策
- (IBAction)privacyButton:(UIButton *)sender
{
    [self showHUDText:@"隐私政策"];
}

#pragma mark - network 

- (void)requestPerfectMessage
{
#warning 请求成功后执行
    HCGradeViewController *grade = [[HCGradeViewController alloc] init];
    [self.navigationController pushViewController:grade animated:YES];
}

@end
