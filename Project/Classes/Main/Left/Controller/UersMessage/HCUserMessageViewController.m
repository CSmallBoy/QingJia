//
//  HCUserMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUserMessageViewController.h"
#import "HCUserCodeViewController.h"
#import "HCUserHeadImageViewController.h"
#import "HCEditUserMessageViewController.h"

#import "HCUserMessageTableViewCell.h"
#import "HCUserMessageInfo.h"
#import "HCPickerView.h"


#define HCUserCell @"HCUserMessageTableViewCell"

@interface HCUserMessageViewController ()<HCPickerViewDelegate,userInfoDelegate>{
    MyselfInfoModel*_model;
}

@property (nonatomic, strong) HCPickerView *datePicker;
@property (nonatomic, strong) HCUserMessageInfo *info;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIImageView *headBackground;
@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation HCUserMessageViewController
- (void)viewWillAppear:(BOOL)animated{
    _dict = [readUserInfo getReadDic];
    NSString *imagestr= _dict[@"UserInf"][@"userPhoto"];
    if (imagestr.length>0) {
        [_headButton setImage:[readUserInfo image64:imagestr]forState:UIControlStateNormal];
    }else{
        [_headButton setImage:OrigIMG(@"2Dbarcode_message_HeadPortraits") forState:UIControlStateNormal];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"个人信息";
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    _info = [[HCUserMessageInfo alloc] init];
    
    self.tableView.tableHeaderView = self.headBackground;
    [self.tableView registerClass:[HCUserMessageTableViewCell class] forCellReuseIdentifier:HCUserCell];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCUserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCUserCell];
    cell.indexPath = indexPath;
    switch (indexPath.row) {
        case 0:
        {
            cell.textField.text = _dict[@"UserInf"][@"trueName"];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {cell.textField.text = _dict[@"UserInf"][@"sex"];
            
        }
            break;
        case 3:
        {
            cell.textField.text = _dict[@"UserInf"][@"birthDay"];
        }
            break;
        case 4:
        {
            cell.textField.text = _dict[@"UserInf"][@"chineseZodiac"];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            cell.textField.text = _dict[@"UserInf"][@"chineseZodiac"];

        }
            break;
        case 7:
        {
            cell.textField.text = _dict[@"UserInf"][@"chineseZodiac"];

        }
            break;
        case 8:
        {
            
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4)
    {
        [self.datePicker show];
        [self.view endEditing:YES];
    }else
    {
        [self.datePicker remove];
    }
    HCViewController *vc = nil;
    if (indexPath.row == 1)
    {
        vc = [[HCUserCodeViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

#pragma mark - HCPickerViewDelegate

- (void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
//    _userInfo.birthday = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    HCUserMessageTableViewCell *cell = (HCUserMessageTableViewCell *)
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textField.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
}

#pragma mark - private methods

- (void)handleRightItem
{
//    [self showHUDText:@"编辑用户信息"];
    HCEditUserMessageViewController *editVC = [[HCEditUserMessageViewController alloc]init];
    editVC.delegate = self;
    [self.navigationController pushViewController:editVC animated:YES];
    
}
-(void)userInfoName:(MyselfInfoModel *)model{
   _model  = model;
}

- (void)handleHeadButton
{
    HCUserHeadImageViewController *headImage = [[HCUserHeadImageViewController alloc] init];
    [self.navigationController pushViewController:headImage animated:YES];
}

#pragma mark - setter 

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

- (HCPickerView *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UIImageView *)headBackground
{
    if (!_headBackground)
    {
        _headBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), WIDTH(self.view)*0.45)];
      
            _headBackground.image = OrigIMG(@"2Dbarcode_message_Background");
        _headBackground.userInteractionEnabled = YES;
        [_headBackground addSubview:self.headButton];
        [_headBackground addSubview:self.nickName];
        [_headBackground addSubview:self.markLabel];
    }
    return _headBackground;
}

- (UIButton *)headButton
{
    if (!_headButton)
    {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(0, 30, WIDTH(self.view)*0.2, WIDTH(self.view)*0.2);
        _headButton.center = CGPointMake(self.view.center.x, _headButton.center.y);
      
        
        [_headButton addTarget:self action:@selector(handleHeadButton) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_headButton, WIDTH(_headButton)*0.5);
    }
    return _headButton;
}

- (UILabel *)nickName
{
    if (!_nickName)
    {
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.headButton)+5, WIDTH(self.view), 20)];
        _nickName.text = @"名字昵称";
        _nickName.textAlignment = NSTextAlignmentCenter;
        _nickName.textColor = [UIColor whiteColor];
    }
    return _nickName;
}

- (UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.nickName)+5, WIDTH(self.view), 20)];
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.text = @"To mark each day count.";
        _markLabel.font = [UIFont systemFontOfSize:15];
    }
    return _markLabel;
}



@end
