//
//  HCFindPwdSecondViewController.m
//  Project
//
//  Created by 陈福杰 on 15/11/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFindPwdSecondViewController.h"
#import "HCLoginViewController.h"
#import "YTKNetworkAgent.h"
#import "HCChangePwdApi.h"

@interface HCFindPwdSecondViewController ()
{
 
    __weak IBOutlet UIView *_pwdVeiw;
    
    __weak IBOutlet UITextField *_pwdTextField;
    
    __weak IBOutlet UIButton *_submitBtn;
}
@end

@implementation HCFindPwdSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"密码找回";
    [self setupBackItem];
    
    ViewBorderRadius(_pwdVeiw, 4, 1, RGB(220, 220, 220));
    ViewRadius(_submitBtn, 4);
    _submitBtn.backgroundColor = kHCNavBarColor;
}

- (IBAction)submitButton:(UIButton *)sender
{
    if (IsEmpty(_pwdTextField.text))
    {
        [self showHUDText:@"请输入密码"];
        return;
    }
    [self requestChangePwd];
}

- (void)backLoginView
{
    //销毁当前网络请求
    [[YTKNetworkAgent sharedInstance] cancelRequest:_baseRequest];
    HCViewController *viewController = nil;
    for (HCViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[HCLoginViewController class]])
        {
            viewController = vc;
        }
    }
    [self.navigationController popToViewController:viewController animated:YES];
    
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
