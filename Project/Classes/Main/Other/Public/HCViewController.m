//
//  HCViewController.m
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCViewController.h"
#import "MBProgressHUD.h"
#import "YTKNetworkAgent.h"

@interface HCViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;
}
@end

@implementation HCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kHCBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //销毁当前网络请求
    [[YTKNetworkAgent sharedInstance] cancelRequest:_baseRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)setupBackItem
{
    HCBarButtonItem *item = [[HCBarButtonItem alloc] initWithBackTarget:self action:@selector(backBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backBtnClick
{
    //销毁当前网络请求
    [self hideHUDView];
    //[[YTKNetworkAgent sharedInstance] cancelIndependentRequests];
    [[YTKNetworkAgent sharedInstance] cancelRequest:_baseRequest];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - touchesBegan

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击空白 消除键盘
    [self.view endEditing:YES];
}

#pragma mark - HUDView

- (void)showErrorHint:(NSError *)error
{
    NSString *msg = @"服务器异常，请稍候再试!";
    switch (error.code) {
        case -999:
            //请求取消，不提示
            return;
        case -1000:
        case -1002:
            msg = @"系统异常，请稍后再试";
            break;
        case -1001:
            msg = @"请求超时，请检查您的网络!";
            break;
        case -1004:
        case -1005:
        case -1006:
        case -1009:
            msg = @"网络异常，请检查您的网络!";
            break;
        default:
            break;
    }
    [self show:msg icon:nil];
}

- (void)showHUDView:(NSString *)text
{
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.delegate = self;
    _HUD.labelText = text;
    [self.view endEditing:YES];
}

- (void)hideHUDView
{
    [_HUD hide:YES];
}

#pragma mark - HUD显示异常

- (void)showHUDText:(NSString *)content
{
    [self show:content icon:nil];
}

- (void)showHUDError:(NSString *)error
{
    [self show:error icon:@"hud_error"];
}

- (void)showHUDSuccess:(NSString *)success
{
    [self show:success icon:@"hud_success2"];
}

- (void)show:(NSString *)text icon:(NSString *)icon
{
    [self hideHUDView];
    UIView *view = self.view;//[UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}



@end
