//
//  HCCustomTagViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//定制标签

#import "HCCustomTagViewController.h"
#import "HCPaymentViewController.h"

#import "HCAvatarMgr.h"
#import "HCCustomTagApi.h"
#import "HCTagUserInfo.h"

#import "HCPickerView.h"
#import "HCCustomTagUserInfoCell.h"
#import "HCCustomTagContactTableViewCell.h"
#import "HCCustomTagUserMedicalCell.h"

@interface HCCustomTagViewController ()<HCPickerViewDelegate,HCCustomTagUserInfoCellDelegate,HCCustomTagContactTableViewCellDelegate,HCCustomTagUserMedicalCellDelegate>

@property (nonatomic, strong) HCPickerView *datePicker;

@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIView *basicInfoHeaderView;
/***添加紧急联系人*/
@property (nonatomic,strong) UIView *contactInfoHeaderView;
@property (nonatomic,strong) UIView *deleteContactInfoView;
@property (nonatomic,strong) UIView *medicalInfoHeaderView;
@property (nonatomic, assign) CGFloat height; // 药物史的高度
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *history;

@property (nonatomic,strong) HCTagUserInfo *tagUserInfo;

@end

@implementation HCCustomTagViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"定制标签";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.datePicker remove];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0)
    {
           static NSString *CustomTagID = @"CustonTag";
        HCCustomTagUserInfoCell *customTagUserInfoCell = [[HCCustomTagUserInfoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomTagID];
        customTagUserInfoCell.delegate = self;
        customTagUserInfoCell.tagUserInfo = _tagUserInfo;
        customTagUserInfoCell.indexPath = indexPath;
        cell = customTagUserInfoCell;
        
    }
    else if (indexPath.section == 3)
    {
        HCCustomTagUserMedicalCell *customTagUserMedicalCell = [[HCCustomTagUserMedicalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Medical"];
        customTagUserMedicalCell.tagUserInfo = _tagUserInfo;
        customTagUserMedicalCell.indexPath = indexPath;
        customTagUserMedicalCell.delegate = self;
            cell = customTagUserMedicalCell;
    }
    else
    {
        HCCustomTagContactTableViewCell *contactCell = [[HCCustomTagContactTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"contactCell"];
        contactCell.tagUserInfo = _tagUserInfo;
        contactCell.indexPath = indexPath;
        contactCell.delegate = self;
        cell = contactCell;
        
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 3)
        {
            [self.view endEditing:YES];
            [self.datePicker show];
        }
        else
        {
            [self.datePicker remove];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  8;
    }
    else if (section == 3)
    {
        return 2;
    }
    else
    {
        return 4;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == 3) ? self.footerView : nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.basicInfoHeaderView;
    }
    else if (section == 1)
    {
        return self.contactInfoHeaderView;
    }
    else if (section == 3)
    {
        return self.medicalInfoHeaderView;
    }
    else
    {
        return self.deleteContactInfoView;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        return (indexPath.row == 0) ? 44 : 88;
    }
    else if (indexPath.section == 0)
    {
        return (indexPath.row == 0) ? 84 : 44;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 3) ? 120 : 1 ;
}


#pragma mark---HCCustomTagUserInfoCellDelegate,HCCustomTagContactTableViewCellDelegate,HCCustomTagUserMedicalCellDelegate

-(void)addUserHeaderIMG
{
    [self.datePicker remove];
    [self.view endEditing:YES];
    
    [HCAvatarMgr manager].isUploadImage = YES;
    [HCAvatarMgr manager].noUploadImage = NO;
    //上传个人头像
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg)
     {
         if (!result)
         {
             [self showHUDText:msg];
             [HCAvatarMgr manager].isUploadImage = NO;
             [HCAvatarMgr manager].noUploadImage = NO;
         }
         else
         {
             [[SDImageCache sharedImageCache] clearMemory];
             [[SDImageCache sharedImageCache] clearDisk];
             [self.tableView reloadData];
         }
     }];
    
}

-(void)dismissDatePicker
{
    [self.datePicker remove];
}

-(void)dismissDatePicker0
{
    [self.datePicker remove];
}

-(void)dismissDatePicker2
{
    [self.datePicker remove];
}

#pragma mark - HCPickerViewDelegate

- (void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    _tagUserInfo.userBirthday = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    HCCustomTagUserInfoCell *cell = (HCCustomTagUserInfoCell *)
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textField.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
}


#pragma mark - private methods

-(void)handleCompeleteButton
{
//    if (IsEmpty(_tagUserInfo.userName))
//    {
//        [self showHUDText:@"请输入姓名"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userGender))
//    {
//        [self showHUDText:@"请输入性别"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userBirthday))
//    {
//        [self showHUDText:@"请输入生日"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userAddress))
//    {
//        [self showHUDText:@"请输入居住地址"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userSchool))
//    {
//        [self showHUDText:@"请输入学校名称"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userPhoneNum) || ![Utils checkPhoneNum:_tagUserInfo.userPhoneNum])
//    {
//        [self showHUDText:@"请输入正确的电话"];
//        return;
//    }
//    if (IsEmpty(_tagUserInfo.userIDCard) || ![Utils chk18PaperId:_tagUserInfo.userIDCard]) {
//        [self showHUDText:@"请输入正确的身份证号码"];
//        return;
//    }
    
    HCPaymentViewController *paymentVC = [[HCPaymentViewController alloc]init];
    [self.navigationController pushViewController:paymentVC animated:YES];
}

-(void)handleAddContact
{
    [self showHUDText:@"增加紧急联系人"];
}

-(void)handleDeleteContact
{
    [self showHUDText:@"收起紧急联系人"];

}

#pragma mark---Setter Or Getter

- (HCPickerView *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

-(UIView*)basicInfoHeaderView
{
    if (!_basicInfoHeaderView)
    {
        _basicInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
       UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH(self.view), 30)];
        headerLabel.text = @"基本信息";
        headerLabel.font = [UIFont systemFontOfSize:12];
        [_basicInfoHeaderView addSubview:headerLabel];
    }
    return _basicInfoHeaderView;
}

-(UIView*)contactInfoHeaderView
{
    if (!_contactInfoHeaderView)
    {
        _contactInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
        headerLabel.text = @"紧急联系人";
        headerLabel.font = [UIFont systemFontOfSize:12];
        
        UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addContactBtn.frame = CGRectMake(70, 5, 20, 20);
        [addContactBtn setBackgroundImage:OrigIMG(@"yihubaiying_but_Plus") forState:UIControlStateNormal];
        [addContactBtn addTarget:self action:@selector(handleAddContact) forControlEvents:UIControlEventTouchUpInside];
        
        [_contactInfoHeaderView addSubview:addContactBtn];

        [_contactInfoHeaderView addSubview:headerLabel];
    }
    return _contactInfoHeaderView;
}

-(UIView *)deleteContactInfoView
{
    if (!_deleteContactInfoView)
    {
        _deleteContactInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
        UIButton *deleteContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteContactBtn setBackgroundImage:OrigIMG(@"yihubaiying_but_reduce") forState:UIControlStateNormal];
        deleteContactBtn.frame = CGRectMake(70, 5, 20, 20);
        [deleteContactBtn addTarget:self action:@selector(handleDeleteContact) forControlEvents:UIControlEventTouchUpInside];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
        headerLabel.text = @"紧急联系人";
        headerLabel.font = [UIFont systemFontOfSize:12];
        [_deleteContactInfoView addSubview:headerLabel];
        
        [_deleteContactInfoView addSubview:deleteContactBtn];
    }
    return _deleteContactInfoView;
}

-(UIView*)medicalInfoHeaderView
{
    if (!_medicalInfoHeaderView)
    {
        _medicalInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 30)];
        headerLabel.text = @"医疗救助信息";
        headerLabel.font = [UIFont systemFontOfSize:12];
        [_medicalInfoHeaderView addSubview:headerLabel];
    }
    return _medicalInfoHeaderView;
}

-(UIView *)footerView
{
    if(!_footerView)
    {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 120)];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(15,40, WIDTH(self.view)-30, 44);
        completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(handleCompeleteButton) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(completeBtn, 4);
        completeBtn.backgroundColor = [UIColor redColor];
        [_footerView addSubview:completeBtn];
    }
    return _footerView;
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(46, 46, 46);
    }
    return _titleLabel;
}

#pragma mark---network

- (void)requestSaveResumeData
{
    [self showHUDView:nil];
    
    HCCustomTagApi *api = [[HCCustomTagApi alloc] init];
    api.info = _tagUserInfo;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"保存成功"];
//            [HCAccountMgr manager].userInfo = _tagUserInfo;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

@end
