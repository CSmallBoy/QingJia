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

#import "JT3DScrollView.h"

@interface HCTagMangerMangerController ()<UIScrollViewDelegate>

@property (nonatomic,strong) JT3DScrollView *scrollView;
@property (nonatomic,strong) UIButton *button;

@end

@implementation HCTagMangerMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 扫描二维码的图标
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick1:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.view addSubview:self.scrollView];
    [self createCardWithColor];
    [self createCardWithColor];
    
    [self.view addSubview:self.button];
}

- (void)createCardWithColor
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame)-70;
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    // 显示的view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor = [UIColor yellowColor];
    
    view.layer.cornerRadius = 8.;
    
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}

#pragma mark ---- scrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateButtons];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateButtons];
}

- (void)updateButtons
{
    if(self.scrollView.currentPage == self.scrollView.subviews.count - 1){
        
        [self.button setTitle:@"标签使用者管理" forState:UIControlStateNormal];
    }
    else{
       
        [self.button setTitle:@"紧急联系人管理" forState:UIControlStateNormal];
    }
}

#pragma mark --- private mothods

// 点击了扫描二维码额图标
-(void)rightItemClick1:(UIBarButtonItem *)right
{

//    ActiveTagScanQCodeViewController *activeVC = [[ActiveTagScanQCodeViewController alloc]init];
//    [self.navigationController pushViewController:activeVC animated:YES];
    
    // 直接跳转到绑定标签的界面
    HCBindTagController *bindVC = [[HCBindTagController alloc]init];
    [self.navigationController pushViewController:bindVC animated:YES];
    
    
}

// 点击了管理按钮

-(void)buttonClick:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"标签使用者管理"]) {
        
        HCTagUserMangerViewController *vc = [[HCTagUserMangerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES
         ];
    }
    else
    {
        HCContactPersonController *VC = [[HCContactPersonController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark --- settet Or getter


- (JT3DScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH-100, SCREEN_HEIGHT-180)];
        _scrollView.effect = JT3DScrollViewEffectCarousel;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


- (UIButton *)button
{
    if(!_button){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(50, SCREEN_HEIGHT-80, SCREEN_WIDTH-100, 40);
        _button.backgroundColor = kHCNavBarColor;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitle:@"紧急联系人管理" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_button, 8);
    }
    return _button;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
