//
//  HCAddPromiseViewController1.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromiseDetailViewController1.h"

#import "HCPickerView.h"
#import "HCAvatarMgr.h"
#import "UUDatePicker.h"

#import "HCPromisedDetailAPI.h"
#import "HCPromisedAddSelectAPI.h"

#import "HCPromisedContractPersonInfo.h"
#import "HCPromisedDetailInfo.h"
#import "HCPromisedMissInfo.h"
#import "HCPromisedListInfo.h"


#import "HCPromisedMissCell.h"
#import "HCBaseDetailUserInfoCell.h"
#import "HCPromisedMedicalCell.h"
#import "HCPromisedContactTableViewCell.h"

@interface HCPromiseDetailViewController1 ()<HCBaseUserInfoCellDelegate,HCPromisedContactTableViewCellDelegate,HCPromisedMedicalCellDelegate,HCPromisedMissCellDelegate,HCPickerViewDelegate>

@property(nonatomic,strong)UIView *dateDetailPicker;
@property(nonatomic,strong) HCPickerView *datePicker;

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
@property (nonatomic,strong)UIImage *image;

@property (nonatomic,strong) UIButton  *Photo;
@property (nonatomic,strong) UILabel   *PhotoLabel;


@property (nonatomic,assign) BOOL isAdd;
@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,strong) HCPromisedDetailInfo *detailInfo;
@property(nonatomic,strong)HCPromisedMissInfo   *missInfo;
@property(nonatomic,strong) NSNumber  *ObjectId;

@end

@implementation HCPromiseDetailViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"一呼百应";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];
    if (self.detailInfo.ContactArray.count ==2)
    {
        _isAdd = NO;
    }
    else
    {
        _isAdd = YES;
    }
    self.ObjectId = self.data [@"ObjectId"];
//    _detailInfo = [[HCPromisedDetailInfo alloc] init];
    _missInfo = [[HCPromisedMissInfo alloc]init];
//    _missInfo.ObjectId = self.ObjectId;
//    _detailInfo.ContactArray  = [NSMutableArray array];
//    [_detailInfo.ContactArray addObject:[[HCPromisedContractPersonInfo alloc] init]];
//    
//    [self requestData];
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
        baseDetailUserInfoCell.image = _image;
        baseDetailUserInfoCell.delegate = self;
        baseDetailUserInfoCell.detailInfo = self.detailInfo;
        baseDetailUserInfoCell.indexPath = indexPath;
        baseDetailUserInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return baseDetailUserInfoCell;
    }
    else if (indexPath.section == (_isAdd ? 2:3))
    {
        HCPromisedMedicalCell * promisedMedicalCell = [[HCPromisedMedicalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"promisedMedical"];
        promisedMedicalCell.detailInfo = self.detailInfo;
        promisedMedicalCell.indexPath = indexPath;
        promisedMedicalCell.delegate = self;
        promisedMedicalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return promisedMedicalCell;
    }
    else  if(indexPath.section == (_isAdd ? 3 :4))
    {
        HCPromisedMissCell * missCell = [[HCPromisedMissCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Miss"];
        missCell.missInfo = _missInfo;
        missCell.indexPath = indexPath;
        missCell.delegate = self;
        missCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return missCell;
    }
    else if (indexPath.section == (_isAdd ? 4 :5))
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoCellID"];
            [cell addSubview:self.Photo];
            [cell addSubview:self.PhotoLabel];
        }
        return cell;
    }
    else
    {
        NSString *DCID = [NSString stringWithFormat:@"contactCell%ld",indexPath.section];
        HCPromisedContactTableViewCell *contactCell = [[HCPromisedContactTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DCID];
        contactCell.isEdit = NO;
        contactCell.delegate = self;
        contactCell.contactArr = self.detailInfo.ContactArray;
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
    }
    else if (indexPath.section == (_isAdd ?3:4))
    {
        
        if (indexPath.row == 1)
        {
            [self.view endEditing:YES];
            [self.view addSubview:self.dateDetailPicker];
        }
    }}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isAdd ? 5 : 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isAdd)
    {
        switch (section)
        {
            case 0:
                return 5;
                break;
            case 1:
                return 3;
                break;
            case 2:
                if (_isShow) {
                    return 6;
                }
                return 0;
                break;
            case 3:
                return 3;
                break;
            case 4:
                return 1;
            default:
                break;
        }
    }
    else
    {

        switch (section)
        {
            case 0:
                return  5;
                break;
            case 1:
                return 3;
                break;
            case 2:
                return 3;
                break;
            case 3:
                if (_isShow) {
                    return 6;
                }
                return 0;
                break;
            case 4:
                return 3;
                break;
            case 5:
                return 1;
            default:
                break;
        }
        
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == (_isAdd ? 4 : 5)) ? self.footerView : nil;
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
        return self.missHeaderView;
        
    }    else if (section == (_isAdd ? 2 : 3))
    {
        return self.medicalInfoHeaderView;
        
    }else if (section == (_isAdd ? 4:5))
    {
        return nil;
    }
    else
    {
        return self.deleteContactInfoView;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == (_isAdd ? 2 : 3))
    {
        return ((indexPath.row == 3)|| (indexPath.row ==5)) ? 88 : 44;
    }else if (indexPath.section == (_isAdd ? 3:4))
    {
        return (indexPath.row == 2) ? 88 : 44;
    }
    else if (indexPath.section == 0)
    {
        return 44;
    }
    else if (indexPath.section == (_isAdd ? 4 : 5))
    {
        return 200;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isAdd) {
        if (section == 4)
        {
            return 20;
        }
        else
        {
            return 40;
        }
    }else
    {
        if (section == 5)
        {
            return 20;
        }
        else
        {
            return 40;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == (_isAdd ? 4 : 5)) ? 120 : 1 ;
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


#pragma mark---HCCustomTagUserInfoCellDelegate,HCCustomTagContactTableViewCellDelegate,HCCustomTagUserMedicalCellDelegate

-(void)addUserHeaderIMG:(UIButton *)button
{
    [self.datePicker remove];
    [self.dateDetailPicker removeFromSuperview];
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
         }
         self.image = image;
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

#pragma mark - private methods

-(void)swiClick:(UISwitch *)swi
{
    if (swi.on) {
        _isShow = YES;
        [self.tableView reloadData];
    }
    else
    {
        _isShow = NO;
        [self.tableView reloadData];
    }
}

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
//    [self requestSelectResumeData];
    //------------------此处代码应该写在提交成功后-----------------
    HCPromisedListInfo  *info =  self.data[@"ListInfo"];
    info.isSend = YES;
    self.block (YES);
    [self.navigationController popToRootViewControllerAnimated:YES];
    //---------------------------------------------------------
   
}

-(void)handleAddContact
{
    if (_isAdd  == YES)
    {
        _isAdd  = !_isAdd;
        [_detailInfo.ContactArray addObject:[[HCPromisedContractPersonInfo alloc] init]];
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

- (UIView *)dateDetailPicker
{
    if(!_dateDetailPicker){
        _dateDetailPicker = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 250)];
        _dateDetailPicker.backgroundColor = [UIColor clearColor];
        UUDatePicker *udatePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 50,SCREEN_WIDTH, 150) PickerStyle:0 didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
            _missInfo.LossTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",year,month,day,hour,minute];
            
            [self.tableView reloadData];
        }];
        udatePicker.maxLimitDate = [NSDate date];
       [_dateDetailPicker addSubview:udatePicker];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_WIDTH-80, 50, 80, 30);
        [button addTarget:self action:@selector(dismissuDatePicker) forControlEvents:UIControlEventTouchUpInside];
        
        [_dateDetailPicker addSubview:button];
    }
    return _dateDetailPicker;
}

-(UIView*)basicInfoHeaderView
{
    if (!_basicInfoHeaderView)
    {
        _basicInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, WIDTH(self.view), 50)];
        headerLabel.text = @"基本信息";
        headerLabel.font = [UIFont systemFontOfSize:14];
        [_basicInfoHeaderView addSubview:headerLabel];
    }
    return _basicInfoHeaderView;
}

-(UIView*)contactInfoHeaderView
{
    if (!_contactInfoHeaderView)
    {
        _contactInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
        headerLabel.text = @"紧急联系人";
        headerLabel.font = [UIFont systemFontOfSize:14];
        [_contactInfoHeaderView addSubview:headerLabel];
    }
    return _contactInfoHeaderView;
}

-(UIView *)deleteContactInfoView
{
    if (!_deleteContactInfoView)
    {
        _deleteContactInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
        headerLabel.text = @"紧急联系人";
        headerLabel.font = [UIFont systemFontOfSize:14];
        [_deleteContactInfoView addSubview:headerLabel];
    }
    return _deleteContactInfoView;
}

- (UIView *)missHeaderView
{
    if(!_missHeaderView){
        _missHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-10, 30)];
        headerLabel.text = @"走失信息";
        headerLabel.font = [UIFont systemFontOfSize:14];
        [_missHeaderView addSubview:headerLabel];
    }
    return _missHeaderView;
}

-(UIView*)medicalInfoHeaderView
{
    if (!_medicalInfoHeaderView)
    {
        _medicalInfoHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 30)];
        UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-10, 30)];
        headerLabel.text = @"医疗救助信息";
        headerLabel.font = [UIFont systemFontOfSize:14];
        [_medicalInfoHeaderView addSubview:headerLabel];
        
        UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60,5, 70, 20)];
        swi.on = NO;
        [swi addTarget:self action:@selector(swiClick:) forControlEvents:UIControlEventValueChanged];
        [_medicalInfoHeaderView addSubview:swi];
        UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor = [UIColor lightGrayColor];
        [_medicalInfoHeaderView addSubview:view];

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


- (HCPromisedDetailInfo *)detailInfo
{
    if(!_detailInfo){
        _detailInfo = [[HCPromisedDetailInfo alloc]init];
        _detailInfo.ObjectXName = @"王二小";
        _detailInfo.ObjectSex = @"男";
        _detailInfo.ObjectBirthDay = @"1992-11-08";
        _detailInfo.ObjectHomeAddress = @"上海市";
        _detailInfo.ObjectSchool = @"第一小学";
        _detailInfo.ObjectIdNo = @"340824111911083226";
        _detailInfo.ObjectCareer = @"学生";
        _detailInfo.BloodType = @"AB";
        _detailInfo.Allergic = @"没有";
    
        HCPromisedContractPersonInfo *info = [[HCPromisedContractPersonInfo alloc]init];
        info.ObjectXName = @"老王一";
        info.ObjectXRelative =@"叔叔1";
        info.PhoneNo = @"12345678909";
        info.IDNo = @"2345245246";
        
        HCPromisedContractPersonInfo *info1 = [[HCPromisedContractPersonInfo alloc]init];
        info1.ObjectXName = @"老王二";
        info1.ObjectXRelative =@"叔叔2";
        info1.PhoneNo = @"0987456789";
        info1.IDNo = @"245634565654u677546";
        
        [_detailInfo.ContactArray addObject:info];
        [_detailInfo.ContactArray addObject:info1];
    }
    return _detailInfo;
}

- (UIButton *)Photo
{
    if(!_Photo){
        _Photo = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _Photo.backgroundColor = [UIColor lightGrayColor];
    }
    return _Photo;
}

- (UILabel *)PhotoLabel
{
    if(!_PhotoLabel){
        _PhotoLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 85, 200, 30)];
        _PhotoLabel.text = @"请点击上传走失者图片";
        _PhotoLabel.textAlignment = NSTextAlignmentCenter;
        _PhotoLabel.textColor = [UIColor blackColor];
    }
    return _PhotoLabel;
}

#pragma mark---network
//请求详情数据
-(void)requestData
{
//    HCPromisedDetailAPI  *api = [[HCPromisedDetailAPI alloc]init];
//    api.ObjectId = self.ObjectId; ;
//    
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *arr) {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            self.detailInfo = arr[0];
//            
//            self.missInfo = arr[1];
//            [self.tableView reloadData];
//        }
//        else
//        {
//            [self showHUDError:message];
//        }
//    }];
}

// 提交数据
-(void)requestSelectResumeData
{
    [self showHUDView:nil];

    HCPromisedAddSelectAPI*api = [[HCPromisedAddSelectAPI alloc] init];
    self.missInfo.ObjectId = @(100000001);
    api.missInfo = self.missInfo;

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"提交成功"];
            [self.tableView reloadData];
        }
        else
        {
            [self showHUDError:message];
        }
    }];
}
@end
