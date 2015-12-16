//
//  ViewController.m
//  PMedical
//
//  Created by Vincent on 15-1-6.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCLoginViewController.h"

//注册修改密码
#import "HCRegistViewController.h"
#import "HCFindPwdViewController.h"
//网络api
#import "HCLoginApi.h"
#import "HCUserApi.h"
#import "HCAppMgr.h"


@interface HCLoginViewController ()
{
    __weak IBOutlet UITextField *_accountTextField;
    __weak IBOutlet UITextField *_keyTextField;
    __weak IBOutlet UIButton    *_loginBtn;
    __weak IBOutlet UIView      *_accountView;
    __weak IBOutlet UIView      *_keyView;
}

@end

@implementation HCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    [self setupBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    ViewBorderRadius(_accountView, 4, 1, RGB(220, 220, 220));
    ViewBorderRadius(_keyView, 4, 1, RGB(220, 220, 220));
    ViewRadius(_loginBtn, 4);
    _loginBtn.backgroundColor = kHCNavBarColor;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _accountTextField.text = [defaults objectForKey:kHCLoginAccount];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

//忘记密码
- (IBAction)forgotKeyBtnClick:(id)sender {
    
    HCFindPwdViewController *vc = [[HCFindPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//注册
- (IBAction)registBtnClick:(id)sender {
    
    HCRegistViewController *regist = [[HCRegistViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

//登录
- (IBAction)loginBtnClick:(id)sender {
    
    if (![Utils checkPhoneNum:_accountTextField.text])
    {
        [self showHUDText:@"输入正确的手机号"];
        return;
    }
    
    if (_keyTextField.text.length == 0)
    {
        [self showHUDText:@"请输入正确的密码"];
        return;
    }
    
    if (_keyTextField.text.length < 6 ||
        _keyTextField.text.length > 20 ||
        [_keyTextField.text rangeOfString:@" "].location != NSNotFound)
    {
        [self showHUDText:@"密码必须由6-20位数字、字母或符号组成"];
        return;
    }
    
    [self requestLogin];
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
