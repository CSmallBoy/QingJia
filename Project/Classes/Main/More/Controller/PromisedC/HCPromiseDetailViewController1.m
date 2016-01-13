//
//  HCAddPromiseViewController1.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromiseDetailViewController1.h"
#import "HCPaymentViewController.h"
#import "HCAvatarMgr.h"
#import "HCPromisedDetailAPI.h"
#import "HCContactPersonInfo.h"
#import "HCPromisedDetailInfo.h"
#import "HCPromisedMissInfo.h"

#import "HCPickerView.h"
#import "HCPromisedMissCell.h"
#import "HCBaseDetailUserInfoCell.h"
#import "HCPromisedMedicalCell.h"
#import "HCCustomTagContactTableViewCell.h"
#import "UUDatePicker.h"
@interface HCPromiseDetailViewController1 ()<HCPickerViewDelegate,HCBaseUserInfoCellDelegate,HCCustomTagContactTableViewCellDelegate,HCPromisedMedicalCellDelegate,HCPromisedMissCellDelegate>

@property (nonatomic, strong) HCPickerView *datePicker;
@property(nonatomic,strong)UIView *dateDetailPicker;

@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIView *basicInfoHeaderView;
/***添加紧急联系人*/
@property (nonatomic,strong) UIView *contactInfoHeaderView;
@property (nonatomic,strong) UIView *deleteContactInfoView;
@property (nonatomic,strong) UIView *missHeaderView;
@property (nonatomic,strong) UIView *medicalInfoHeaderView;
@property (nonatomic, assign) CGFloat height; // 药物史的高度
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *history;

@property (nonatomic,assign) BOOL isAdd;

@property (nonatomic,strong) HCPromisedDetailInfo *detailInfo;
@property(nonatomic,strong)HCPromisedMissInfo   *missInfo;

@end

@implementation HCPromiseDetailViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];

    if (_detailInfo.ContactArray.count ==2) {
        _isAdd = NO;
    }
    else
    {
        _isAdd = YES;
    }
    _detailInfo = [[HCPromisedDetailInfo alloc] init];
    _missInfo = [[HCPromisedMissInfo alloc]init];
    _detailInfo.ContactArray  = [NSMutableArray array];
    [_detailInfo.ContactArray addObject:[[HCContactPersonInfo alloc] init]];
    
    [self requestData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.datePicker remove];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        HCBaseDetailUserInfoCell *baseDetailUserInfoCell =[[HCBaseDetailUserInfoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"baseInfo"];
        baseDetailUserInfoCell.delegate = self;
        baseDetailUserInfoCell.detailInfo = _detailInfo;
        baseDetailUserInfoCell.indexPath = indexPath;
        baseDetailUserInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return baseDetailUserInfoCell;
    }
    else if (indexPath.section == (_isAdd ? 3 :4))
    {
        HCPromisedMedicalCell * promisedMedicalCell = [[HCPromisedMedicalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"promisedMedical"];
        promisedMedicalCell.detailInfo = _detailInfo;
        promisedMedicalCell.indexPath = indexPath;
        promisedMedicalCell.delegate = self;
        promisedMedicalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return promisedMedicalCell;
    }
    else  if(indexPath.section == (_isAdd ? 2:3))
    {
        HCPromisedMissCell * missCell = [[HCPromisedMissCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Miss"];
        missCell.missInfo = _missInfo;
        missCell.indexPath = indexPath;
        missCell.delegate = self;
        missCell.isAdd = _isAdd;
        missCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return missCell;
         
    }
    else
    {
        NSString *DCID = [NSString stringWithFormat:@"contactCell%ld",indexPath.section];
        HCCustomTagContactTableViewCell *contactCell = [[HCCustomTagContactTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DCID];
        contactCell.delegate = self;
        contactCell.contactArr = _detailInfo.ContactArray;
        
        contactCell.indexPath = indexPath;
        contactCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contactCell;
    }
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
    }else if (indexPath.section == (_isAdd ?2:3))
      {
        
        if (indexPath.row == 1) {
            [self.view endEditing:YES];
            [self.view addSubview:self.dateDetailPicker];
        }
      
    }
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isAdd ? 4 : 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isAdd)
    {
        switch (section) {
            case 0:
                return 6;
                break;
            case 1:
                return 4;
                break;
            case 2:
                return 3;
                break;
            case 3:
                return 2;
                break;
            default:
                break;
        }
    }else
    {
        switch (section) {
            case 0:
                return  8;
                break;
            case 1:
                return 4;
                break;
            case 2:
                return 4;
                break;
            case 3:
                return 3;
                break;
            case 4:
                return 2;
                break;
            default:
                break;
        }
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == (_isAdd ? 3 : 4)) ? self.footerView : nil;
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
    else if (section == (_isAdd ? 3 : 4))
    {
        return self.medicalInfoHeaderView;
    }
    else if (section == (_isAdd ? 2 : 3))
    {
        return self.missHeaderView;
        
    }else
    {
       return self.deleteContactInfoView;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == (_isAdd ? 2 : 3))
    {
        return ((indexPath.row == 0)|| (indexPath.row ==1)) ? 44 : 88;
    }else if (indexPath.section == (_isAdd ? 3:4))
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
    return (section == (_isAdd ? 3 : 4)) ? 120 : 1 ;
}


#pragma mark---HCCustomTagUserInfoCellDelegate,HCCustomTagContactTableViewCellDelegate,HCCustomTagUserMedicalCellDelegate

-(void)addUserHeaderIMG:(UIButton *)button
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
         [button setBackgroundImage:image forState:UIControlStateNormal];
         [self.tableView reloadData];
     }];
}

-(void)dismissDatePicker
{
    [self.datePicker remove];
    [self.dateDetailPicker removeFromSuperview];
}

-(void)dismissDatePicker0
{
    [self.datePicker remove];
    [self.dateDetailPicker removeFromSuperview];

}

-(void)dismissDatePicker2
{
    [self.datePicker remove];
    [self.dateDetailPicker removeFromSuperview];

}

#pragma mark - HCPickerViewDelegate

- (void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    _detailInfo.ObjectBirthDay = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    HCBaseDetailUserInfoCell *cell = (HCBaseDetailUserInfoCell *)
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
//    [self requestSaveResumeData];
   
}

-(void)handleAddContact
{
    if (_isAdd  == YES)
    {
        _isAdd  = !_isAdd;
        [_detailInfo.ContactArray addObject:[[HCContactPersonInfo alloc] init]];
        [self.tableView reloadData];
       
    }
    
}

-(void)handleDeleteContact
{
    _isAdd  = !_isAdd;
    [_detailInfo.ContactArray removeObjectAtIndex:1];
    [self.tableView reloadData];
}

-(void)dismissuDatePicker
{
    [self.dateDetailPicker removeFromSuperview];

}

#pragma mark---Setter Or Getter

- (UIView *)dateDetailPicker
{
    if(!_dateDetailPicker){
        _dateDetailPicker = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 250)];
        _dateDetailPicker.backgroundColor = [UIColor whiteColor];
        UUDatePicker *udatePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(20, 50,SCREEN_WIDTH, 200) PickerStyle:0 didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
            _missInfo.LossTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",year,month,day,hour,minute];
            [self.tableView reloadData];
        }];
        udatePicker.maxLimitDate = [NSDate date];
       [_dateDetailPicker addSubview:udatePicker];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 50);
        [button addTarget:self action:@selector(dismissuDatePicker) forControlEvents:UIControlEventTouchUpInside];
        
        [_dateDetailPicker addSubview:button];
    }
    return _dateDetailPicker;
}


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
        
//        UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        addContactBtn.frame = CGRectMake(70, 5, 20, 20);
//        if (_isAdd)
//        {
//            [addContactBtn addTarget:self action:@selector(handleAddContact) forControlEvents:UIControlEventTouchUpInside];
//        }
//        else
//        {
//            return nil;
//        }
//        [addContactBtn setBackgroundImage:OrigIMG(@"yihubaiying_but_Plus") forState:UIControlStateNormal];
//        
//        [_contactInfoHeaderView addSubview:addContactBtn];
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

- (UIView *)missHeaderView
{
    if(!_missHeaderView){
        _missHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 30)];
        headerLabel.text = @"走失信息";
        headerLabel.font = [UIFont systemFontOfSize:12];
        [_missHeaderView addSubview:headerLabel];
    }
    return _missHeaderView;
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

-(void)requestData
{
    HCPromisedDetailAPI  *api = [[HCPromisedDetailAPI alloc]init];
    api.ObjectId = self.ObjectId; ;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *arr) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            self.detailInfo = arr[0];
            
            self.missInfo = arr[1];
            [self.tableView reloadData];
        }
        else
        {
            [self showHUDError:message];
        }
        
        
        
    }];
    
}

@end
