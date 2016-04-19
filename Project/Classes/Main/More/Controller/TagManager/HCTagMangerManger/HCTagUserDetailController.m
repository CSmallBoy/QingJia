//
//  HCTagUserDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserDetailController.h"
#import "HCAddTagUserController.h"
#import "HCNewTagInfo.h"
#import "HCTagUserDetailCell.h"
#import "HCPickerView.h"
#import "HCAvatarMgr.h"

#import "HCTagAddObjectApi.h"
#import "HCContractPersonListApi.h"
#import "HCTagUserFindApi.h"

#import "HCTagContactInfo.h"// 联系人模型


@interface HCTagUserDetailController ()<HCPickerViewDelegate>
@property (nonatomic,strong) HCPickerView *datePicker;
@property (nonatomic,strong) NSString *myTitle;
@property (nonatomic,strong) HCNewTagInfo *info;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIView *medicalView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *contactArr;// 联系人数组
@property (nonatomic,assign) NSInteger openHealthCard;
@property (nonatomic,assign) BOOL  isHide;


@end

@implementation HCTagUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    self.myTitle = self.data[@"title"];
    self.info = self.data[@"info"];
    
    
    self.myTitle = self.info.trueName;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:2];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self setupBackItem];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    item.title = @"编辑";
    self.title = [NSString stringWithFormat:@"%@的信息",self.myTitle];
 
    
    self.navigationItem.rightBarButtonItem = item;
    
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
        
        
        if ([_info.openHealthCard isEqualToString:@"0"]) {
            
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
        return 150;
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
        
        for (UIView *view in self.scrollView.subviews) {
            
            [view removeFromSuperview];
        }
        
        for (int i = 0; i< self.contactArr.count; i++)
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

             [ self.scrollView addSubview:view];
        }
        
        [cell addSubview:self.scrollView];
        return cell;

        
    }else
    {
        HCTagUserDetailCell *cell = [HCTagUserDetailCell cellWithTableView:tableView];
        cell.info = self.info;
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
    HCAddTagUserController *addVC = [[HCAddTagUserController alloc]init];
    addVC.data = @{@"info":self.info};
    addVC.isEdit = YES;
    [self.navigationController pushViewController:addVC animated:YES];
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _scrollView.contentSize = CGSizeMake(93*2, 150);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


- (NSInteger)openHealthCard
{
    if(!_openHealthCard){
        _openHealthCard = 1;
    }
    return _openHealthCard;
}


- (NSMutableArray *)contactArr
{
    if(!_contactArr){
        _contactArr = [NSMutableArray array];
    }
    return _contactArr;
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

    }
    return _medicalView;
}


#pragma mark --- network


-(void)requestData
{
    HCTagUserFindApi *api = [[HCTagUserFindApi alloc]init];
    
    HCNewTagInfo *info = self.data[@"info"];
    
    api.objectId = info.objectId;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
      
        if (requestStatus == HCRequestStatusSuccess) {
            
            NSDictionary *dic = respone[@"Data"][@"objectInf"];
            self.info = [HCNewTagInfo mj_objectWithKeyValues:dic];
            
            HCTagContactInfo *info1 = [[HCTagContactInfo alloc]init];
            info1.trueName = self.info.contactorTrueName1;
            info1.phoneNo = self.info.contactorPhoneNo1;
            info1.relative = self.info.relation1;
            info1.imageName = self.info.imageName1;
            
            HCTagContactInfo *info2 = [[HCTagContactInfo alloc]init];
            info2.trueName = self.info.contactorTrueName2;
            info2.phoneNo = self.info.contactorPhoneNo2;
            info2.relative = self.info.relation2;
            info2.imageName = self.info.imageName2;
            
            [self.contactArr addObject:info1];
            [self.contactArr addObject:info2];
            
            [self.tableView reloadData];
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
