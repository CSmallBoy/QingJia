//
//  PMFindPwdViewController.m
//  PMedical
//
//  Created by Vincent on 15-5-26.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCFindPwdViewController.h"
#import "HCFindPwdSecondViewController.h"
#import "HCGetCodeApi.h"
#import "HCCheckCodeApi.h"
#import "TOWebViewController.h"
#import "HCGetVerificationCodeApi.h"
#import "NHCResgistVerifyApi.h"
@interface HCFindPwdViewController ()
{
    __weak IBOutlet UIButton    *_nextBtn;
    
    __weak IBOutlet UITextField *_mobileTextField;
    __weak IBOutlet UITextField *_checkNumTextField;
    
    __weak IBOutlet UILabel     *_timeNumLabel;
    __weak IBOutlet UIButton    *_timeBtn;
    
    NSTimer  *_timer;
    long     _timeNum;
}
@property (nonatomic,copy)NSString *uuid;
@end

@implementation HCFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码找回";
    _uuid = [readUserInfo GetUUID];
    [self setupBackItem];
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
//        if (_checkNumTextField.text.length < 4) {
//            [self showHUDText:@"输入正确的验证码"];
//            return;
//        }
    [self requestCheckCode];
}

#pragma mark - network

//获取验证码

- (void)requestGetCode
{
    [self showHUDView:nil];
    HCGetVerificationCodeApi *apiGet = [[HCGetVerificationCodeApi alloc]init];
    apiGet.uuid = _uuid;
    apiGet.phoneNumber = _mobileTextField.text;
    apiGet.thetype = @"1001";
    [apiGet startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus +100 == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"获取成功"];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

// 校验验证码

- (void)requestCheckCode
{
    [self showHUDView:nil];
    NHCResgistVerifyApi *cheakApi = [[NHCResgistVerifyApi alloc]init];
    cheakApi.PhoneNumber = _mobileTextField.text;
    cheakApi.theType = @"1001";
    cheakApi.theCode = _checkNumTextField.text;
    cheakApi.uuid = _uuid;
    [cheakApi startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            HCFindPwdSecondViewController *pwdsecond = [[HCFindPwdSecondViewController alloc] init];
            //此处没有返回token  不需要用
            pwdsecond.data = @{@"phonenumber": _mobileTextField.text};
            [self.navigationController pushViewController:pwdsecond animated:YES];
        }else
        {
            [self showHUDError:message];
        }
        
    }];
    
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            [self hideHUDView];
//            HCFindPwdSecondViewController *pwdsecond = [[HCFindPwdSecondViewController alloc] init];
//            pwdsecond.data = @{@"phonenumber": _mobileTextField.text, @"token": data[@"Token"]};
//            [self.navigationController pushViewController:pwdsecond animated:YES];
//        }else
//        {
//            [self showHUDError:message];
//        }
//    }];
}

@end
