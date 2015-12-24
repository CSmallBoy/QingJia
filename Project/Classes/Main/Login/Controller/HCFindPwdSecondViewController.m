//
//  HCFindPwdSecondViewController.m
//  Project
//
//  Created by 陈福杰 on 15/11/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFindPwdSecondViewController.h"
#import "HCLoginViewController.h"
#import "TOWebViewController.h"
#import "HCChangePwdApi.h"

@interface HCFindPwdSecondViewController ()
{
    __weak IBOutlet UITextField *_pwdTextField;
    
    __weak IBOutlet UITextField *_repwdTextField;
    __weak IBOutlet UIButton *_submitBtn;
}
@end

@implementation HCFindPwdSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置新密码";
    [self setupBackItem];
    ViewRadius(_submitBtn, 4);
}

//显示注册协议详情
- (IBAction)showRegistrationAgreement:(id)sender
{
    TOWebViewController *web = [[TOWebViewController alloc] initWithURLString:@"http://172.16.171.62/app/registerLaw.html"];
    web.title = @"服务协议";
    web.navigationButtonsHidden = YES;
    [self.navigationController pushViewController:web animated:YES];
}
//显示注册隐私协议详情
- (IBAction)showRegistPrivacyAgreement:(id)sender
{
    TOWebViewController *web = [[TOWebViewController alloc] initWithURLString:@"http://172.16.171.62/app/registerLaw.html"];
    web.title = @"隐私政策";
    web.navigationButtonsHidden = YES;
    [self.navigationController pushViewController:web animated:YES];
}

- (IBAction)submitButton:(UIButton *)sender
{
    if (IsEmpty(_pwdTextField.text))
    {
        [self showHUDText:@"请输入密码"];
        return;
    }
//    [self requestChangePwd];
}


#pragma mark - network

- (void)requestChangePwd
{
    [self showHUDView:nil];
    
    HCChangePwdApi *api = [[HCChangePwdApi alloc] init];
    api.password = _pwdTextField.text;
    api.token = self.data[@"token"];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"密码修改成功"];
            [self performSelector:@selector(backLoginView) withObject:nil afterDelay:1.2f];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
