//
//  HCLostInfoViewController.m
//  钦家
//
//  Created by Tony on 16/5/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLostInfoViewController.h"

#import "HCLostInfoCell.h"
#import "HCNewTagInfo.h"
//下个界面
#import "HCTagEditContractPersonController.h"

//辅助类
#import "HCAvatarMgr.h"
#import "HCPickerView.h"

@interface HCLostInfoViewController ()<UITableViewDelegate,UITableViewDataSource,HCPickerViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) UIButton     *nextStep;//下一步
@property (nonatomic, strong) UIView       *medicalView;//区头(医疗急救卡)
@property (nonatomic, strong) HCPickerView *datePicker;//时间选择器
@property (nonatomic, strong) HCNewTagInfo *info;//储存新建走失者信息
@property (nonatomic, strong) UIImage      *image;//储存头像


@end

@implementation HCLostInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"走失者信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.info = [[HCNewTagInfo alloc] init];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nextStep];
}

#pragma mark - lazyLoding

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)medicalView
{
    if (_medicalView == nil)
    {
        _medicalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _medicalView.backgroundColor = kHCBackgroundColor;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 40)];
        label.textColor = [UIColor blackColor];
        label.text = @"医疗急救卡";
        [_medicalView addSubview:label];
        
        //开关
        UISwitch *onOff = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 40, 30)];
        [onOff addTarget:self action:@selector(onOffAction:) forControlEvents:UIControlEventValueChanged];
        onOff.on = YES;
        [_medicalView addSubview:onOff];
    }
    return _medicalView;
}

- (UIButton *)nextStep
{
    if (_nextStep == nil)
    {
        _nextStep = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT-50, SCREEN_WIDTH-20, 40)];
        _nextStep.backgroundColor = kHCNavBarColor;
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_nextStep, 5);
        [_nextStep addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}

- (HCPickerView *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.delegate = self;
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}

#pragma mark - tableView delegate/dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }
    else
    {
        if (self.info.isBlack)//医疗健康卡
        {
            return 0;
        }
        else
        {
            return 4;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }
    else
    {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 60;
    }
    if (indexPath.section == 1 && indexPath.row == 3)
    {
        return 80;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.medicalView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCLostInfoCell *cell = [HCLostInfoCell cellWithTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = self.info;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)//选择头像
    {
        [self getImageFormCamera];
    }
    else if (indexPath.section == 0 && indexPath.row == 3)//选择生日
    {
        [self getDateByPicker];
    }
}

#pragma mark - pickerDelegate
- (void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    self.info.birthDay = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - buttonClick

//医疗急救卡开关
- (void)onOffAction:(UISwitch *)sender
{
    if (sender.on)//打开开关
    {
        self.info.isBlack = NO;//当isBlack为NO时证明打开了健康医疗卡
    }
    else//关闭开关
    {
        self.info.isBlack = YES;
    }
    [self.tableView reloadData];
}

//下一步 跳转至新增紧急联系人
- (void)nextStepAction:(UIButton *)sender
{
    HCTagEditContractPersonController *contactVC = [[HCTagEditContractPersonController alloc] init];
    [self.navigationController pushViewController:contactVC animated:YES];
}

#pragma mark - datePicker/imagePicker

//调用相册
- (void)getImageFormCamera
{
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            self.info.headImage = image;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
    }];
}

//调用时间选择器
- (void)getDateByPicker
{
    [self.datePicker show];
}


@end
