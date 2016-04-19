//
//  HCTagUserDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddTagUserController.h"
#import "HCTagEditContractPersonController.h"

#import "HCNewTagInfo.h"
#import "HCTagUserDetailCell.h"
#import "HCPickerView.h"
#import "HCAvatarMgr.h"

#import "HCTagAddObjectApi.h"
#import "HCContractPersonListApi.h"
#import "HCTagChangeObjectApi.h"

#import "HCTagContactInfo.h"// 联系人模型


@interface HCAddTagUserController ()<HCPickerViewDelegate>
@property (nonatomic,strong) HCPickerView *datePicker;
@property (nonatomic,strong) NSString *myTitle;
@property (nonatomic,strong) HCNewTagInfo *info;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIView *medicalView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *contactArr;// 联系人数组
@property (nonatomic,strong) NSMutableArray *selectArr;

@property (nonatomic,strong) NSString* openHealthCard;
@property (nonatomic,assign) BOOL  isHide;
@property (nonatomic,strong) UISwitch *sw;

@end

@implementation HCAddTagUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = self.data[@"title"];
    self.info = self.data[@"info"];
    self.myTitle = self.info.trueName;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    [self setupBackItem];
  
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];

    item.title = @"保存";
    self.title = @"新增标签使用者";
    
    self.navigationItem.rightBarButtonItem = item;
    
    HCNewTagInfo *info = self.data[@"info"];
    info.openHealthCard = self.openHealthCard;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self requestContactData];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 6;
    }
    else if (section == 1)
    {
        if (_isHide) {
            return 0;
        }
        
        HCNewTagInfo *info = self.data[@"info"];
        if ([info.openHealthCard isEqualToString:@"0"]) {
            
            return 0;
        }
        
        return 6;
        
        
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return 0.1;
    }
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 1 && indexPath.row == 3)||
        (indexPath.section == 1 && indexPath.row == 4)||
        (indexPath.section == 1 && indexPath.row == 5)) {
        
        return 88;
        
    }
    else if (indexPath.section == 2 )
    {
        return 180;
    }
    else
    {
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        for (int i = 0; i<self.contactArr.count; i++) {
            
            if (i == 0)
            {
               
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , 93, 180)];
                // 添加联系人按钮
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10, 20, 73, 73);
                [button setImage:IMG(@"Classinfo_but_plus") forState:UIControlStateNormal];
                [button addTarget:self action:@selector(addContactPerson:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                // 添加联系人label
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 73, 20)];
                label.textColor = [UIColor blackColor];
                label.text = @"添加联系人";
                label.adjustsFontSizeToFitWidth  = YES;
                [view addSubview:label];
                
                [self.scrollView addSubview:view];
                
            }
            else
            {
                HCTagContactInfo *info = self.contactArr[i];
                
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*93,0 , 93, 180)];
               
                // 头像
                UIImageView *imageIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 73, 73)];
                
                NSURL *url = [readUserInfo originUrl:info.imageName :@"contactor"];
                [imageIV sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
                ViewRadius(imageIV, 73/2);
                [view addSubview:imageIV];
                
                // 姓名label
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 93, 20)];
                label.textColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = info.trueName;
                [view addSubview:label];
                
                //选中按钮
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(31, 130, 30, 30);
                [button setImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
                [button addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = 100+i ;
                [view addSubview:button];
                
                [ self.scrollView addSubview:view];

            
            }
        }
        [cell addSubview:self.scrollView];
        return cell;
        
        
    }
    else
    {
        HCTagUserDetailCell *cell = [HCTagUserDetailCell cellWithTableView:tableView];
        cell.info = self.data[@"info"];
        cell.image = self.image;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        return cell;
    }
    
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1)
    {
         return self.medicalView;
        
    }
    else if (section ==2)
    {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = kHCBackgroundColor;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"紧急联系人";
        label.adjustsFontSizeToFitWidth = YES;
        [view addSubview:label];
        
        return view;
        

    }
    
    return nil;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        [self.view endEditing:NO];
        [self.datePicker show];
        
    }
    else  if (indexPath.section == 0  && indexPath.row == 0)
    {
        [self.datePicker removeFromSuperview];
        [self showAlbum];
    }
    else
    {
        [self.datePicker removeFromSuperview];
    }
}

#pragma mark --- HCPickerViewDelegate

-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    self.info.birthDay = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark --- private  mothods

-(void)itemClick:(UIBarButtonItem *)item
{
        // 保存按钮点击
       
        
        if (IsEmpty(self.info.trueName)) {
            [self showHUDText:@"请输入姓名"];
            return;
        }
        if (IsEmpty(self.info.sex)) {
            [self showHUDText:@"请输入生日"];
            return;
        }
        if (IsEmpty(self.info.homeAddress)) {
            [self showHUDText:@"请输入住址"];
            return;
        }
        if (IsEmpty(self.info.school)) {
            [self showHUDText:@"请输入学校"];
            return;
        }
    
    if ([self.openHealthCard isEqualToString:@"1"]) {
        
        if (IsEmpty(self.info.height)) {
            [self showHUDText:@"请输入身高"];
            return;
        }
        if (IsEmpty(self.info.weight)) {
            [self showHUDText:@"请输入体重"];
            return;
        }
        if (IsEmpty(self.info.bloodType)) {
            [self showHUDText:@"请输入血型"];
            return;
        }
        if (IsEmpty(self.info.allergic)) {
            [self showHUDText:@"请输入过敏史"];
            return;
        }
        if (IsEmpty(self.info.cureCondition)) {
            [self showHUDText:@"请输入医疗状况"];
            return;
        }
        if (IsEmpty(self.info.cureNote)) {
            [self showHUDText:@"请输入医疗笔记"];
            return;
        }
    }
        if (self.selectArr.count != 2) {
            
            [self showHUDText:@"必须绑定连个紧急联系人"];
            return;
        }

    if (_isEdit)
    {
        if (self.image) {
            [self uploadImage];
        }
        else
        {
            [self changeObject];
        }
       
       
    }else
    {
        if (self.image)
        {
            [self uploadImage];
        }
    
    }
}



// 点击了选中联系人按钮

-(void)selectBtnClick:(UIButton *)button
{
    UIImage *image = [button imageForState:UIControlStateNormal];
    
    if ([image isEqual:IMG(@"buttonNormal")]) {
        
        
        if (self.selectArr.count == 2)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能绑定两个紧急联系人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        else
        {
            NSInteger index = button.tag-100;
            [self.selectArr addObject:self.contactArr[index]];
           [button setImage:IMG(@"buttonSelected") forState:UIControlStateNormal];
        }
    }
    else
    {
        [button setImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        NSInteger index = button.tag-100;
        HCNewTagInfo *info = self.contactArr[index];
        [self.selectArr removeObject:info];
    }

}

// 跳转到 新增紧急联系人界面

-(void)addContactPerson:(UIButton *)buton
{
    HCTagEditContractPersonController *editVC = [[HCTagEditContractPersonController alloc]init];
    
    [self.navigationController pushViewController:editVC animated:YES];
}


-(void)showAlbum
{
    [self.datePicker remove];
    [self.view endEditing:YES];
    

    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
    }];


}


// 点击医疗急救卡的
-(void)swClick:(UISwitch *)sw
{
    if (sw.on) {
        self.openHealthCard = @"1";
        sw.on = YES;
        _isHide = NO;
        
        HCNewTagInfo *info = self.data[@"info"];
        info.openHealthCard = @"1";
        [self.tableView reloadData];
        
    }
    else
    {
        self.openHealthCard = @"0";
        sw.on = NO;
        _isHide = YES;
        
        HCNewTagInfo *info = self.data[@"info"];
        info.openHealthCard = @"0";
        
        [self.tableView reloadData];
        
    }
    
}

#pragma mark--- setter Or getter

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


- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


- (NSMutableArray *)contactArr
{
    if(!_contactArr){
        _contactArr = [NSMutableArray array];
    }
    return _contactArr;
}


- (NSMutableArray *)selectArr
{
    if(!_selectArr){
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

- (UIView *)medicalView
{
    if(!_medicalView){
        _medicalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _medicalView.backgroundColor = kHCBackgroundColor;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"医疗急救卡";
        label.adjustsFontSizeToFitWidth = YES;
        [_medicalView addSubview:label];
        
        _sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 5, 40, 30)];
        
        HCNewTagInfo *info = self.data[@"info"];
        if ([info.openHealthCard isEqualToString:@"0"]) {
            
            _sw.on = NO;;
        }
        else
        {
           _sw.on = YES;
        }
        
        
        [_sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
        [_medicalView addSubview:_sw];
        
    }
    return _medicalView;
}


#pragma mark --- network

-(void)uploadImage
{
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkUser,uuid,token]];
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.info.imageName = responseObject[@"Data"][@"files"][0];

        if (_isEdit)
        {
            [self changeObject];
        }
        else
        {
           [self requestData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    

}
// 添加对象的Api

-(void)requestData
{

    HCTagAddObjectApi *api = [[HCTagAddObjectApi alloc]init];
    
    HCTagContactInfo *info1 =self.selectArr[0];
    HCTagContactInfo *info2 = self.selectArr[1];
    
    self.info.relation1 = @"关系1";
    self.info.contactorId1 = info1.contactorId;
    
    self.info.relation2 = @"关系2";
    self.info.contactorId2 = info2.contactorId;
    
    api.info = self.info;
    
    api.openHealthCard = self.openHealthCard;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"添加标签使用者成功"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void)changeObject
{
    HCTagChangeObjectApi *api = [[HCTagChangeObjectApi alloc]init];
    
    api.objectId = self.info.objectId;
    
    HCTagContactInfo *info1 =self.selectArr[0];
    HCTagContactInfo *info2 = self.selectArr[1];
    
    self.info.relation1 = @"关系1";
    self.info.contactorId1 = info1.contactorId;
    
    self.info.relation2 = @"关系2";
    self.info.contactorId2 = info2.contactorId;
    
    api.openHealthCard = self.openHealthCard;
    
    api.info =  self.info;
    
    [api startRequest:^(HCRequestStatus requestStautus, NSString *message, id respone) {
       
        if (requestStautus == HCRequestStatusSuccess) {
    
//            NSDictionary *dic = @{@"arr":self.selectArr};
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeContactImg" object:nil userInfo:dic];
            UIViewController *vc = self.navigationController.viewControllers[3];
             [self.navigationController popToViewController:vc animated:YES];
            
        }
    }];
    
    
}

-(void)requestContactData
{

    HCContractPersonListApi *api = [[HCContractPersonListApi alloc]init];
    
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            [self.contactArr removeAllObjects];
            NSArray *array = respone[@"Data"][@"rows"];
            
            for (NSDictionary *dic in array) {
                HCTagContactInfo *info = [HCTagContactInfo  mj_objectWithKeyValues:dic];
                
                [self.contactArr addObject:info];
                
                
            }
            
            HCTagContactInfo *info = [[HCTagContactInfo alloc]init];
            info.trueName = @"添加联系人";
            
            [self.contactArr insertObject:info atIndex:0];
            
            
            self.scrollView.contentSize = CGSizeMake(93 * self.contactArr.count, 120);
             NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
