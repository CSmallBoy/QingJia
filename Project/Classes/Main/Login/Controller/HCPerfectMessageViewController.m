//
//  HCPerfectMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPerfectMessageViewController.h"
#import "HCGradeViewController.h"
#import "HCPerfectMessageApi.h"
#import "NHCRegisteredApi.h"
#import "HCPickerView.h"
@interface HCPerfectMessageViewController ()<HCPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *birTime;

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
    if (IsEmpty(_nameTextField.text))
    {
        [self showHUDText:@"请输入姓名"];
        return;
    }
    if (IsEmpty(_password.text) || IsEmpty(_repassword.text))
    {
        [self showHUDText:@"请输入密码"];
        return;
    }
    if (![_password.text isEqualToString:_repassword.text])
    {
        [self showHUDText:@"输入的密码不一致"];
        return;
    }
    if(_password.text.length<6 || _repassword.text.length<6){
        [self showHUDText:@"密码大于6位"];
        return;
    }
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
    [self showHUDView:nil];
    NHCRegisteredApi *apiUser = [[NHCRegisteredApi alloc]init];
    apiUser.TrueName =_nameTextField.text;
    apiUser.passWord = _password.text;
    apiUser.birthday = _birTime.titleLabel.text;
    apiUser.userName = _userNumNmae;
    NSString *key = @"0";
    if (_womenBtn.selected)
    {
        key = @"1";
    }
    apiUser.sex = [HCDictionaryMgr getSexStringWithKey:key];
    //环信的注册
    //[[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_userNumNmae password:_password.text];
    [apiUser startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            
            [HCAccountMgr manager].loginInfo = loginInfo;  
            [[HCAccountMgr manager] saveLoginInfoToDB];
            [HCAccountMgr manager].isLogined = YES;
            HCGradeViewController *grade = [[HCGradeViewController alloc] init];
            [self.navigationController pushViewController:grade animated:YES];
        }else
        {
            [self showHUDError:message];
        }

    }];
    

}
//创建时间选择器
- (IBAction)CreatDatePicker:(UIButton *)sender {
    HCPickerView *pick;
    pick = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                              datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
    pick.datePicker.maximumDate = [NSDate date];
    pick.delegate = self;
    pick.delegate = self;
    [self.view addSubview:pick];
}
-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result{
    NSDate *date = result[@"date"];
     [_birTime setTitle:[Utils getDateStringWithDate:date format:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
}

@end
