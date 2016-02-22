//
//  HCProductionCenterController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductionCenterController.h"

@interface HCProductionCenterController ()
@property (nonatomic,strong) UIView    *grayView;
@property (nonatomic,strong) UIButton  *taoBaoBtn;
@property (nonatomic,strong) UIButton  *jinDongBtn;
@property (nonatomic,strong) UIWebView   *taoBaoWebView;
@property (nonatomic,strong) UIWebView   *jinDongWebView;

@end

@implementation HCProductionCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kHCBackgroundColor;
    self.title = @"产品中心";
    [self setupBackItem];
    [self.view addSubview:self.taoBaoWebView];
    [self.view addSubview:self.jinDongWebView];
    self.jinDongWebView.hidden = YES;
    [self.view addSubview:self.taoBaoBtn];
    [self.view addSubview:self.jinDongBtn];
    [self.view addSubview:self.grayView];
}


#pragma mark --- private mothods

-(void)showTaoBaoWebView
{
    self.jinDongWebView.hidden = YES;
}

-(void)showJinDongWebView
{
    self.jinDongWebView.hidden = NO;
}

#pragma mark setter Or getter


- (UIButton *)taoBaoBtn
{
    if(!_taoBaoBtn){
        _taoBaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _taoBaoBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH/2, 50);
        _taoBaoBtn.backgroundColor = kHCBackgroundColor;
        [_taoBaoBtn addTarget:self action:@selector(showTaoBaoWebView) forControlEvents:UIControlEventTouchUpInside];
//        [_taoBaoBtn setBackgroundImage:IMG(@"taoBao") forState:UIControlStateNormal];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-(100/175.0*SCREEN_WIDTH/2)/2, 12, 100/175.0*SCREEN_WIDTH/2, 25)];
        imageView.image = IMG(@"taoBao");
        [_taoBaoBtn addSubview:imageView];
       
    }
    return _taoBaoBtn;
}



- (UIButton *)jinDongBtn
{
    if(!_jinDongBtn){
        _jinDongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jinDongBtn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-50, SCREEN_WIDTH/2, 50);
        [_jinDongBtn addTarget:self action:@selector(showJinDongWebView) forControlEvents:UIControlEventTouchUpInside];
//        [_jinDongBtn setBackgroundImage:IMG(@"jinDong") forState: UIControlStateNormal];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-(100/175.0*SCREEN_WIDTH/2)/2, 12, 100/175.0 * SCREEN_WIDTH/2, 25)];
        imageView.image = IMG(@"jinDong");
        [_jinDongBtn addSubview:imageView];
    }
    return _jinDongBtn;
}


- (UIWebView *)taoBaoWebView
{
    if(!_taoBaoWebView){
        _taoBaoWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
        NSURLRequest  *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.taobao.com"]];
        [_taoBaoWebView loadRequest:request];
    }
    return _taoBaoWebView;
}


- (UIWebView *)jinDongWebView
{
    if(!_jinDongWebView){
        _jinDongWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50-64)];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.jd.com"]];
        [_jinDongWebView loadRequest:request];
    }
    return _jinDongWebView;
}


- (UIView *)grayView
{
    if(!_grayView){
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT-50, 1, 50)];
        _grayView.backgroundColor = [UIColor grayColor];
    }
    return _grayView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
