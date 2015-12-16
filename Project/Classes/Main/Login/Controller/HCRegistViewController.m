//
//  PMRegistViewController.m
//  PMedical
//
//  Created by Vincent on 15-1-13.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCRegistViewController.h"
#import "TOWebViewController.h"

@interface HCRegistViewController ()

@end

@implementation HCRegistViewController
{
    __weak IBOutlet UIButton    *_registBtn;
    
    __weak IBOutlet UITextField *_mobileTextField;
    __weak IBOutlet UITextField *_pwdTextField;
    __weak IBOutlet UITextField *_checkNumTextField;
    
    __weak IBOutlet UILabel     *_timeNumLabel;
    __weak IBOutlet UIButton    *_timeBtn;
    
    __weak IBOutlet UIView      *_mobileView;
    __weak IBOutlet UIView      *_checkNumView;
    __weak IBOutlet UIView      *_pwdView;

    NSTimer  *_timer;
    long     _timeNum;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";
    [self setupBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置圆角
    ViewBorderRadius(_mobileView, 4, 1, RGB(220, 220, 220));
    ViewBorderRadius(_checkNumView, 4, 1, RGB(220, 220, 220));
    ViewBorderRadius(_pwdView, 4, 1, RGB(220, 220, 220));
    ViewRadius(_registBtn, 4.0f);
    _registBtn.backgroundColor = kHCNavBarColor;
    ViewRadius(_timeNumLabel, 3.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - NSTimer
//启动心跳
- (void)startTimer
{
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
    [self requestCheckCode];
}

//显示注册协议详情
- (IBAction)showRegistrationAgreement:(id)sender
{
    TOWebViewController *web = [[TOWebViewController alloc] initWithURLString:@"http://172.16.171.62/app/registerLaw.html"];
    web.title = @"注册协议";
    web.navigationButtonsHidden = YES;
    [self.navigationController pushViewController:web animated:YES];
}
//显示注册隐私协议详情
- (IBAction)showRegistPrivacyAgreement:(id)sender
{
    TOWebViewController *web = [[TOWebViewController alloc] initWithURLString:@"http://172.16.171.62/app/registerLaw.html"];
    web.title = @"隐私协议";
    web.navigationButtonsHidden = YES;
    [self.navigationController pushViewController:web animated:YES];
}

//点击 注册
-(IBAction)registBtnClick:(id)sender
{
    if (![Utils checkPhoneNum:_mobileTextField.text]) {
        [self showHUDText:@"输入正确的手机号"];
        return;
    }
    if (_pwdTextField.text.length < 6 ||
        _pwdTextField.text.length > 20 ||
        [_pwdTextField.text rangeOfString:@" "].location != NSNotFound) {
        [self showHUDText:@"密码必须由6-20位数字、字母或符号组成"];
        return;
    }
    if (![Utils checkPassWord:_pwdTextField.text]) {
        [self showHUDText:@"不允许设置连续密码"];
        return;
    }
    if (_checkNumTextField.text.length < 4) {
        [self showHUDText:@"输入正确的验证码"];
        return;
    }
    [self registNewAccount];
}

#pragma mark - network

//获取验证码
- (void)requestCheckCode
{
    [self showHUDView:nil];
    
    NSDictionary *dic = @{@"t": @"User,msgCode", @"phone": _mobileTextField.text};
    _baseRequest = [[HCJsonRequestApi alloc] initWithBody:dic];
    
    [_baseRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request){
        NSDictionary *data = (NSDictionary *)request.responseJSONObject;
        [self parseCheckCode:data];
        
    } failure:^(YTKBaseRequest *request){
        DLog(@"error:%@",request.requestOperation.error);
        [self showErrorHint:request.requestOperation.error];
    }];
}

//解析验证码
- (void)parseCheckCode:(NSDictionary *)data
{
    int code = [data[@"data"] intValue];
    NSString *msg = data[@"msg"];
    if (code == 1) {
        _registBtn.enabled = YES;
        [_registBtn setBackgroundColor:kHCNavBarColor];
        [self showHUDSuccess:@"发送成功"];
    }else {
        [self showHUDError:msg];
    }
}

//注册
- (void)registNewAccount
{
    [self showHUDView:nil];
    
    NSDictionary *dic = @{@"t": @"User,register", @"phone": _mobileTextField.text,@"password": _pwdTextField.text, @"msgcode": _checkNumTextField.text};
    
    _baseRequest = [[HCJsonRequestApi alloc] initWithBody:dic];
    
    [_baseRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request){
        NSDictionary *data = (NSDictionary *)request.responseJSONObject;
        [self parseRegistResult:data];
        
    } failure:^(YTKBaseRequest *request){
        DLog(@"error:%@",request.requestOperation.error);
        [self showErrorHint:request.requestOperation.error];
    }];
}
//解析注册结果
- (void)parseRegistResult:(NSDictionary *)dic
{
    int code = [dic[@"state"] intValue];
    NSString *msg = dic[@"msg"];
    if (code == 1) {
        [self showHUDSuccess:@"注册成功"];
        [UIView animateKeyframesWithDuration:1 delay:2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        } completion:^(BOOL finished) {
            [self backBtnClick];
        }];
        
    }else {
        [self showHUDError:msg];
    }
}

@end
