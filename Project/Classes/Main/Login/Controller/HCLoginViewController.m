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
#import "HCAppMgr.h"

#import "AppDelegate.h"
#import "HCHomeViewController.h"


#import "NHCRegisteredApi.h"
#import "NHCLoginApi.h"
#import "NHCResgistVerifyApi.h"
#import "HCGetVerificationCodeApi.h"
#import "NHCCancellationApi.h"
#import "NHCSetNewPassWordApi.h"
#import "NHCUSerInfoApi.h"
//
#import "NHCChatUserInfoApi.h"
#import "HCEaseUserInfo.h"

@interface HCLoginViewController ()
{
    __weak IBOutlet UITextField *_accountTextField;
    __weak IBOutlet UITextField *_keyTextField;
    __weak IBOutlet UIButton    *_loginBtn;
    __weak IBOutlet UIView      *_contentView;
}
@property (nonatomic,strong) NSMutableDictionary *dict_muta;
@property (nonatomic,strong) NSMutableDictionary *dict_muta_nickName;
@end

@implementation HCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dict_muta = [NSMutableDictionary dictionary];
    _dict_muta_nickName = [NSMutableDictionary dictionary];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    ViewRadius(_loginBtn, 4);
    ViewRadius(_contentView, 4);
    
    _accountTextField.text = [self lastLoginUsername];

    
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


#pragma  mark - private
//保存最后一次登录名
- (void)saveLastLoginUsername
{
    //NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
    
    NSString *username = [readUserInfo getReadDic][@"UserInf"][@"phoneNo"];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
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
- (IBAction)loginBtnClick:(id)sender
{
        if (![Utils checkPhoneNum:_accountTextField.text])
        {
            [self showHUDText:@"输入正确的手机号"];
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

    NHCLoginApi *api = [[NHCLoginApi alloc] init];
    api.UserName = _accountTextField.text;
    api.UserPWD = _keyTextField.text;

    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo){

        if (requestStatus == HCRequestStatusSuccess)
        {
            //之前环信的版本
//            [self loginWithUsername:_accountTextField.text password:_keyTextField.text loginInfo:loginInfo];
            //服务器的版本
            [self loginWithUsername:loginInfo.chatName password:loginInfo.chatPwd loginInfo:loginInfo];
        }else
        {
            [self showHUDError:message];
        }
        
    }];
}

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password loginInfo:(HCLoginInfo *)info
{
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHUDView];
         if (loginInfo && !error)
         {
             [self showHUDSuccess:@"登陆成功"];
             [HCAccountMgr manager].loginInfo = info;
             [HCAccountMgr manager].isLogined = YES;
             //登录信息存数据库
             [[HCAccountMgr manager] saveLoginInfoToDB];
             // 环信数据
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             //获取群组列表
             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             
             
             
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             //保存最近一次登录用户名
             [self saveLastLoginUsername];
             //保存登陆过后信息
             

         }
         else
         {
             switch (error.errorCode)
             {
                 case EMErrorNotFound:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorNetworkNotConnected:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 default:
                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
             }
         }
     } onQueue:nil];
}
@end
