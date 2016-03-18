//
//  HCProductionCenterController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCProductionCenterController.h"
#import "HCButtonItem.h"
#import "HCMtalkShopingController.h"

@interface HCProductionCenterController ()
@property (nonatomic,strong) UIView    *grayView;
@property (nonatomic,strong) HCButtonItem  *taoBaoBtn;
@property (nonatomic,strong) HCButtonItem  *jinDongBtn;
@property (nonatomic,strong) HCButtonItem  *MtalkBtn;

@property (nonatomic,strong) UIView *footerView;

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
    [self.view addSubview:self.footerView];
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

-(void)toNextController
{
    HCMtalkShopingController *malkVC = [[HCMtalkShopingController alloc]init];
    [self.navigationController pushViewController:malkVC animated:YES];
    
    
}


#pragma mark setter Or getter


- (HCButtonItem *)taoBaoBtn
{
    if(!_taoBaoBtn){
         _taoBaoBtn = [[HCButtonItem alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"taoBao" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"淘宝购买", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        [_taoBaoBtn addTarget:self action:@selector(showTaoBaoWebView) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _taoBaoBtn;
}



- (HCButtonItem *)jinDongBtn
{
    if(!_jinDongBtn){
         _jinDongBtn = [[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"jinDong" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"京东购买", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        [_jinDongBtn addTarget:self action:@selector(showJinDongWebView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jinDongBtn;
}


- (HCButtonItem *)MtalkBtn
{
    if(!_MtalkBtn){
        
        _MtalkBtn = [[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"mtalklogo" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"购买Malk", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        [_MtalkBtn addTarget:self action:@selector(toNextController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MtalkBtn;
}



- (UIWebView *)taoBaoWebView
{
    if(!_taoBaoWebView){
        _taoBaoWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        NSURLRequest  *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.taobao.com"]];
        [_taoBaoWebView loadRequest:request];
    }
    return _taoBaoWebView;
}


- (UIWebView *)jinDongWebView
{
    if(!_jinDongWebView){
        _jinDongWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-60-64)];
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

-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-60 , SCREEN_WIDTH, 60)];
        _footerView.backgroundColor = kHCBackgroundColor;
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 1)];
        topView.backgroundColor = [UIColor lightGrayColor];
        [_footerView addSubview:topView];
        
        UIView *lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-1, 10, 1, 40)];
        lineViewOne.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewOne];
        
        UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2-2, 10, 1, 40)];
        lineViewTwo.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewTwo];
        
        [_footerView addSubview: self.taoBaoBtn];
        [_footerView addSubview: self.MtalkBtn];
        [_footerView addSubview: self.jinDongBtn];
    }
    return _footerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
