//
//  HCTagMangerMangerController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagMangerMangerController.h"
#import "HCContactPersonController.h"
#import "ActiveTagScanQCodeViewController.h"

#import "HCTagUserMangerViewController.h"

#import "HCBindTagController.h"
#import "lhScanQCodeViewController.h"
#import "JT3DScrollView.h"

@interface HCTagMangerMangerController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIButton *contantPersonBtn;
@property (nonatomic,strong) UIButton  *taguserBtn;
@property (nonatomic,strong) UILabel  *contantPersonLabel;
@property (nonatomic,strong) UILabel  *tagUserLabel;


@end

@implementation HCTagMangerMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 扫描二维码的图标
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick1:)];
//    self.navigationItem.rightBarButtonItem = right;

    [self.view addSubview:self.contantPersonBtn];
    [self.view addSubview:self.contantPersonLabel];
    
    [self.view addSubview:self.taguserBtn];
    [self.view addSubview:self.tagUserLabel];
}




#pragma mark --- private mothods

// 点击了扫描二维码额图标
-(void)rightItemClick1:(UIBarButtonItem *)right
{

    lhScanQCodeViewController   *scanVC = [[lhScanQCodeViewController alloc]init];
    scanVC.isActive = YES;
    [self.navigationController pushViewController:scanVC animated:YES];


    
    // 直接跳转到绑定标签的界面
//    HCBindTagController *bindVC = [[HCBindTagController alloc]init];
//    [self.navigationController pushViewController:bindVC animated:YES];
    
    
}

// 点击紧急联系人
-(void)contactBtnClick:(UIButton *)button
{
    HCContactPersonController *vc = [[HCContactPersonController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)taguserBtnClick:(UIButton *)button

{
    HCTagUserMangerViewController *vc = [[HCTagUserMangerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --- settet Or getter


- (UIButton *)contantPersonBtn
{
    if(!_contantPersonBtn){
        _contantPersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat  btnW = 210/375.0*SCREEN_WIDTH;
        CGFloat  btnH = 200/667.0*SCREEN_HEIGHT;
        _contantPersonBtn.frame = CGRectMake(SCREEN_WIDTH/2-btnW/2, 95/667.0*SCREEN_HEIGHT, btnW, btnH);
        [_contantPersonBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contantPersonBtn setBackgroundImage:IMG(@"ContactPersonManger") forState:UIControlStateNormal];
        ViewRadius(_contantPersonBtn, 5);
    }
    return _contantPersonBtn;
}


- (UIButton *)taguserBtn
{
    if(!_taguserBtn){
        _taguserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat  btnW = 210/375.0*SCREEN_WIDTH;
        CGFloat  btnH = 200/667.0*SCREEN_HEIGHT;
        _taguserBtn.frame = CGRectMake(SCREEN_WIDTH/2-btnW/2,380/667.0*SCREEN_HEIGHT, btnW, btnH);
        [_taguserBtn addTarget:self action:@selector(taguserBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_taguserBtn setBackgroundImage:IMG(@"tagUserManger") forState:UIControlStateNormal];
        ViewRadius(_taguserBtn, 5);
      
    }
    return _taguserBtn;
}


- (UILabel *)contantPersonLabel
{
    if(!_contantPersonLabel){
        CGFloat labelW =210/375.0*SCREEN_WIDTH;
        CGFloat labelH = 30/667.0 *SCREEN_HEIGHT;
        _contantPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-labelW/2, 310/667.0*SCREEN_HEIGHT, labelW,labelH)];
        _contantPersonLabel.text = @"紧急联系人管理";
        _contantPersonLabel.textColor = [UIColor blackColor];
        _contantPersonLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contantPersonLabel;
}


- (UILabel *)tagUserLabel
{
    if(!_tagUserLabel){
        CGFloat labelW =210/375.0*SCREEN_WIDTH;
        CGFloat labelH = 30/667.0 *SCREEN_HEIGHT;
        _tagUserLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-labelW/2, 595/667.0 *SCREEN_HEIGHT, labelW, labelH)];
        _tagUserLabel.text = @"标签使用者管理";
        _tagUserLabel.textColor = [UIColor blackColor];
        _tagUserLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagUserLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
