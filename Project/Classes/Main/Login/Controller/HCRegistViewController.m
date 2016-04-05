//
//  HCRegistViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRegistViewController.h"
#import "HCPerfectMessageViewController.h"
#import "TOWebViewController.h"
#import "HCGetCodeApi.h"
#import "HCCheckCodeApi.h"
#import "HCGetVerificationCodeApi.h"
#import "NHCResgistVerifyApi.h"
@interface HCRegistViewController (){
    NSString *uuid;
}

@end

@implementation HCRegistViewController
{
    __weak IBOutlet UIButton    *_nextBtn;
    
    __weak IBOutlet UITextField *_mobileTextField;
    __weak IBOutlet UITextField *_checkNumTextField;
    
    __weak IBOutlet UILabel     *_timeNumLabel;
    __weak IBOutlet UIButton    *_timeBtn;
    
    NSTimer  *_timer;
    long     _timeNum;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";
    [self setupBackItem];
     uuid = [[NSUUID UUID] UUIDString];
    //设置圆角
    ViewRadius(_nextBtn, 4.0f);
    ViewRadius(_timeNumLabel, 3.0f);
}

#pragma mark - NSTimer
//启动心跳
- (void)startTimer
{
    _timeNumLabel.backgroundColor = [UIColor lightGrayColor];
    if ([_timer isValid] || _timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timeNum = 60;
    _timeNumLabel.text = [NSString stringWithFormat:@"%ld秒",--_timeNum];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimerAction) userInfo:nil repeats:YES];
}

- (void)handleTimerAction
{
    _timeBtn.enabled = NO;
    _timeNumLabel.text = [NSString stringWithFormat:@"%ld秒",--_timeNum];
    if (_timeNum == 0) {
        [_timer invalidate];
        _timer = nil;
        _timeNumLabel.backgroundColor = RGB(251, 25, 53);
        _timeNumLabel.text = @"重新获取";
        _timeBtn.enabled = YES;
    }
}

#pragma mark - IBAction

//点击获取 验证码
-(IBAction)getCheckNumBtnClick:(id)sender
{
    if (![Utils checkPhoneNum:_mobileTextField.text]) {
        [self showHUDText:@"请输入正确的手机号"];
        return;
    }
    [self startTimer];
    [self requestGetCode];
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

//点击 下一步
-(IBAction)nextBtnClick:(id)sender
{
    if (![Utils checkPhoneNum:_mobileTextField.text]) {
        [self showHUDText:@"输入正确的手机号"];
        return;
    }
//    if (_checkNumTextField.text.length < 4) {
//        [self showHUDText:@"输入正确的验证码"];
//        return;
//    }
    [self requestCheckCode];
}

#pragma mark - network

//获取验证码

- (void)requestGetCode
{
    [self showHUDView:nil];
    
    HCGetVerificationCodeApi *api = [[HCGetVerificationCodeApi alloc] init];
    api.phoneNumber = _mobileTextField.text;
    api.uuid = uuid;
    api.thetype = @"1000";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus+100 == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"获取成功"];
        }else
        {
            [self showHUDError:message];
        }
    }];
    //之前代码 已经注释
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data)
//    {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            [self showHUDSuccess:@"获取成功"];
//        }else
//        {
//            [self showHUDError:message];
//        }
//    }];
}

// 校验验证码

- (void)requestCheckCode
{
    [self showHUDView:nil];
    
    NHCResgistVerifyApi *api = [[NHCResgistVerifyApi alloc] init];
    api.PhoneNumber = _mobileTextField.text;
    api.theCode = _checkNumTextField.text;
    api.uuid = uuid;
    api.theType = @"1000";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus +100== HCRequestStatusSuccess)
        {
            [self hideHUDView];
            HCPerfectMessageViewController *perfect = [[HCPerfectMessageViewController alloc] init];
            //新版本  此处没有token
           // perfect.data = @{@"phonenumber": _mobileTextField.text, @"token": data[@"Token"]};
            perfect.userNumNmae = _mobileTextField.text;
            [self.navigationController pushViewController:perfect animated:YES];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
