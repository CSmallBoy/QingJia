
//
//  HCInputWaybillNumViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCInputWaybillNumViewController.h"

@interface HCInputWaybillNumViewController ()

@property (nonatomic,strong) UITextField *textFiled;
@property (nonatomic,strong) UIButton *completeBtn;

@end

@implementation HCInputWaybillNumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"输入运单号";
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.completeBtn];
}

#pragma mark---private Method

-(void)clickCompleteBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---Setter Or Getter

-(UITextField *)textFiled
{
    if (!_textFiled)
    {
        _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 84, SCREEN_WIDTH -130,50)];
        _textFiled.textAlignment = NSTextAlignmentLeft;
        _textFiled.placeholder = @"输入退货的运单号";
        _textFiled.backgroundColor = [UIColor whiteColor];
        _textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _textFiled;
}

-(UIButton *)completeBtn
{
    if (!_completeBtn)
    {
        _completeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.frame = CGRectMake(SCREEN_WIDTH-110, 84, 100, 50);
        [_completeBtn setBackgroundColor:[UIColor redColor]];
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(clickCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
@end
