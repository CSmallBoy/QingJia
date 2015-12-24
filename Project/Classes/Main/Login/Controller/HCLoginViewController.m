//
//  ViewController.m
//  PMedical
//
//  Created by Vincent on 15-1-6.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCLoginViewController.h"
#import "HCRegistViewController.h"
#import "HCFindPwdViewController.h"
#import "HCLoginApi.h"
#import "HCUserApi.h"
#import "HCAppMgr.h"

#import "AppDelegate.h"


@interface HCLoginViewController ()
{
    __weak IBOutlet UITextField *_accountTextField;
    __weak IBOutlet UITextField *_keyTextField;
    __weak IBOutlet UIButton    *_loginBtn;
    __weak IBOutlet UIView      *_contentView;
}

@end

@implementation HCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    ViewRadius(_loginBtn, 4);
    ViewRadius(_contentView, 4);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _accountTextField.text = [defaults objectForKey:kHCLoginAccount];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - IBAction

//忘记密码
- (IBAction)forgotKeyBtnClick:(id)sender {
    
    HCFindPwdViewController *vc = [[HCFindPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//注册
- (IBAction)registBtnClick:(id)sender
{
    HCRegistViewController *regist = [[HCRegistViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

//登录
- (IBAction)loginBtnClick:(id)sender {
    
//    if (![Utils checkPhoneNum:_accountTextField.text])
//    {
//        [self showHUDText:@"输入正确的手机号"];
//        return;
//    }
//    
//    if (_keyTextField.text.length == 0)
//    {
//        [self showHUDText:@"请输入正确的密码"];
//        return;
//    }
//    
//    if (_keyTextField.text.length < 6 ||
//        _keyTextField.text.length > 20 ||
//        [_keyTextField.text rangeOfString:@" "].location != NSNotFound)
//    {
//        [self showHUDText:@"密码必须由6-20位数字、字母或符号组成"];
//        return;
//    }
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
//    [self requestLogin];
}

#pragma amrk - network

//登录
- (void)requestLogin
{
    [self showHUDView:@"正在登录"];

    HCLoginApi *api = [[HCLoginApi alloc] init];
    api.mobile = _accountTextField.text;
    api.password = _keyTextField.text;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo){
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            [HCAccountMgr manager].loginInfo = loginInfo;
            
            //登录信息存数据库
            [[HCAccountMgr manager] saveLoginInfoToDB];
            [HCAccountMgr manager].isLogined = YES;
            [self requestUserData];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:loginInfo.phone forKey:kHCLoginAccount];
            
        }else {
            [self showHUDError:message];
        }
    }];
}

- (void)requestUserData
{
    HCUserApi *api = [[HCUserApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCUserInfo *userinfo) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [HCAccountMgr manager].userInfo = userinfo;
            [[HCAccountMgr manager] updateUserInfoToDB];
            
            [self backBtnClick];
        }
    }];
}

@end
