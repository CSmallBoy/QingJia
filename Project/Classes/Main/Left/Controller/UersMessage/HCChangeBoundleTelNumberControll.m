//
//  HCChangeBoundleTelNumberControll.m
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCChangeBoundleTelNumberControll.h"

#import "HCEditUserMessageViewController.h"
#import "HCChangeBounleTelNumberCell.h"

#import "HCGetCodeApi.h"
#import "HCCheckCodeApi.h"

#import "Utils.h"

@interface HCChangeBoundleTelNumberControll ()

@property (nonatomic,strong) UILabel * timeNumLabel;
@property (nonatomic,strong) UIButton *timeBtn;
@property (nonatomic,strong) NSTimer  *timer;
@property (nonatomic,assign) NSInteger timeNum;
@property (nonatomic,strong)  NSString *phoneNum;
@property (nonatomic,strong)  NSString *codeNum;
@property (nonatomic,strong) UITextField  *textField;

@end

@implementation HCChangeBoundleTelNumberControll

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机号";
    [self setupBackItem];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.view addSubview:self.tableView];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(70, 80,300, 20)];
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.placeholder = @"请输入验证码";
    _textField.textColor = [UIColor blackColor];
    [self.tableView addSubview:self.textField];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCodeNumber:) name:@"getCodeNumber" object:nil];
   
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCChangeBounleTelNumberCell  *cell = [HCChangeBounleTelNumberCell cellWithTableView:tableView];
    cell.isSure = self.isSure;
    cell.codeNum = self.codeNum;
    cell.indexPath = indexPath;
    if (indexPath.row == 1) {
        UITextField *textFIeld = (UITextField *)[cell viewWithTag:101];
        self.codeNum = textFIeld.text;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UIButton  *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(15, 30, SCREEN_WIDTH-30, 30) ;
    [nextBtn setBackgroundColor:COLOR(222, 35, 46, 1)];
    [nextBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    if (_isSure) {
        [nextBtn setTitle:@"确定修改绑定" forState:UIControlStateNormal];
    }else
    {
       [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    
    ViewRadius(nextBtn, 5);
    [view addSubview:nextBtn];
    
    UILabel *garyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 15)];
    garyLabel.text = @"点击上面按“下一步”即表示您同意";
    garyLabel.font = [UIFont systemFontOfSize:10];
    garyLabel.textAlignment = NSTextAlignmentCenter;
    garyLabel.textColor = [UIColor grayColor];
    [view addSubview:garyLabel];
    
    UILabel  *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, 15)];
    blueLabel.text = @"《服务协议》《隐私协议》";
    blueLabel.textAlignment = NSTextAlignmentCenter;
    blueLabel.font = [UIFont systemFontOfSize:10];
    blueLabel.textColor = COLOR(49, 162, 246, 1);
    blueLabel.adjustsFontSizeToFitWidth = YES;
    [view addSubview:blueLabel];
    
    return view;
}


#pragma mark --- private mothods

-(void)getCodeNumber:(NSNotification *)nofi
{
     _phoneNum = nofi.userInfo[@"phoneNum"];
    if (![Utils checkPhoneNum:_phoneNum]) {
        [self showHUDText:@"请输入正确的手机号"];
        return;
    }
    [self startTime];
    [self requestgetCode];
}

-(void)nextStep:(UIButton *)button
{
    
    if (_isSure)
    {
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
    }
    else
    {
        HCChangeBoundleTelNumberControll *sureVC = [[HCChangeBoundleTelNumberControll alloc]init];
        sureVC.isSure = YES;
        [self.navigationController pushViewController:sureVC animated:YES];
//        if (![Utils checkPhoneNum:self.phoneNum]) {
//            [self showHUDText:@"输入正确的手机号"];
//            return;
//        }
//        
//        
//        if (self.textField.text.length < 6) {
//            [self showHUDText:@"输入正确的验证码"];
//            return;
//        }
//        [self requestcheckCode];

       
    }
}

-(void)startTime
{
    [self.tableView addSubview:self.timeNumLabel];
    self.timeNumLabel.backgroundColor = [UIColor lightGrayColor];
    if ([_timer isValid] || _timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timeNum = 60;
    _timeNumLabel.text = [NSString stringWithFormat:@"%ld秒",--_timeNum];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clickTimerAction) userInfo:nil repeats:YES];
}


- (void)clickTimerAction
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


#pragma mark --- getter Or setter

- (UILabel *)timeNumLabel
{
    if(!_timeNumLabel){
        _timeNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90,25, 80, 31)];
        _timeNumLabel.textAlignment = NSTextAlignmentCenter;
        ViewRadius(_timeNumLabel, 5);
    }
    return _timeNumLabel;
}


- (UIButton *)timeBtn
{
    if(!_timeBtn){
        _timeBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        _timeBtn.backgroundColor =COLOR(222, 35, 46, 1);
        [_timeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        ViewRadius(_timeBtn, 5);
    }
    return _timeBtn;
}


#pragma mark - network

//获取验证码

- (void)requestgetCode
{
    [self showHUDView:nil];
    
    HCGetCodeApi *api = [[HCGetCodeApi alloc] init];
    api.phoneNumber = _phoneNum;
    api.thetype = 1000;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data)
     {
         if (requestStatus == HCRequestStatusSuccess)
         {
             [self showHUDSuccess:@"获取成功"];
         }else
         {
             [self showHUDError:message];
         }
     }];
}


// 校验验证码

- (void)requestcheckCode
{
    [self showHUDView:nil];
    
    HCCheckCodeApi *api = [[HCCheckCodeApi alloc] init];
    api.PhoneNumber = self.phoneNum;
    api.theCode = [self.codeNum integerValue];
    api.theType = 1000;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            HCChangeBoundleTelNumberControll *sureVC = [[HCChangeBoundleTelNumberControll alloc]init];
            sureVC.isSure = YES;
            [self.navigationController pushViewController:sureVC animated:YES];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
