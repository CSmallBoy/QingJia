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

@interface HCRegistViewController ()

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
    [self requestCheckCode];
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
//    if (![Utils checkPhoneNum:_mobileTextField.text]) {
//        [self showHUDText:@"输入正确的手机号"];
//        return;
//    }
//    if (_checkNumTextField.text.length < 4) {
//        [self showHUDText:@"输入正确的验证码"];
//        return;
//    }
#warning 发送验证码到服务器
    HCPerfectMessageViewController *perfect = [[HCPerfectMessageViewController alloc] init];
    [self.navigationController pushViewController:perfect animated:YES];
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
        [self showHUDSuccess:@"发送成功"];
    }else {
        [self showHUDError:msg];
    }
}


@end
