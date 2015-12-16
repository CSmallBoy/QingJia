//
//  PMFindPwdViewController.m
//  PMedical
//
//  Created by Vincent on 15-5-26.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCFindPwdViewController.h"
#import "HCFindPwdSecondViewController.h"

@interface HCFindPwdViewController ()
{
    
    NSTimer        *_timer;
    long           _timeNum;
    
    __weak  IBOutlet  UITextField *_mobileTextField;
    __weak  IBOutlet  UITextField *_checkNumTextField;
    
    __weak  IBOutlet  UILabel     *_timeNumLabel;
    __weak  IBOutlet  UIButton    *_timeBtn;
    
    __weak IBOutlet   UIView      *_mobileView;
    __weak IBOutlet   UIView      *_checkNumView;
    
    __weak IBOutlet   UIButton    *_nextBtn;
}

@end

@implementation HCFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码找回";
    
    [self setupBackItem];
    
    [self setupCustomView];
}


#pragma mark - layout

- (void)setupCustomView
{
    //设置圆角
    ViewRadius(_timeNumLabel, 3.0f);
    ViewRadius(_nextBtn, 4);
    _nextBtn.backgroundColor = kHCNavBarColor;
    _nextBtn.enabled = NO;
    ViewBorderRadius(_mobileView, 4, 1, RGB(220, 220, 220));
    ViewBorderRadius(_checkNumView, 4, 1, RGB(220, 220, 220));
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
- (IBAction)nextButton:(UIButton *)sender
{
    if (![Utils checkPhoneNum:_mobileTextField.text])
    {
        [self showHUDText:@"请输入手机"];
        return;
    }
    if (IsEmpty(_checkNumTextField.text))
    {
        [self showHUDText:@"请输入验证码"];
        return;
    }
    [self requestCheckCodeTure];
}

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


#pragma mark - network

//获取验证码
- (void)requestCheckCode
{
    [self showHUDView:nil];
    
    NSDictionary *dic = @{@"t": @"User,msgCode", @"phone": _mobileTextField.text};
    _baseRequest = [[HCJsonRequestApi alloc] initWithBody:dic];
    [_baseRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSInteger code = [request.responseJSONObject[@"state"] integerValue];
        if (code == 1)
        {
            [self showHUDSuccess:@"获取成功"];
            _nextBtn.enabled = YES;
        }else
        {
            [self showHUDError:@"获取失败，请稍后再试"];
        }
    } failure:^(YTKBaseRequest *request) {
        [self showErrorHint:request.requestOperation.error];
    }];
}

- (void)requestCheckCodeTure
{
    [self showHUDView:nil];
    
    NSDictionary *dic = @{@"t": @"User,forgetpassword", @"phone": _mobileTextField.text, @"msgcode": _checkNumTextField.text};
    _baseRequest = [[HCJsonRequestApi alloc] initWithBody:dic];
    [_baseRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSInteger code = [request.responseJSONObject[@"state"] integerValue];
        if (code == 1)
        {
            [self hideHUDView];
            // 验证码正确，跳转
            HCFindPwdSecondViewController *second = [[HCFindPwdSecondViewController alloc] init];
            NSDictionary *dic = request.responseJSONObject[@"data"];
            second.data = @{@"token": dic[@"token"]};
            [self.navigationController pushViewController:second animated:YES];
        }else
        {
            [self showHUDError:request.responseJSONObject[@"msg"]];
        }
    } failure:^(YTKBaseRequest *request) {
        [self showErrorHint:request.requestOperation.error];
    }];

}




@end
