//
//  HCTagUserDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserDetailController.h"
#import "HCNewTagInfo.h"
#import "HCTagUserDetailCell.h"
#import "HCPickerView.h"
#import "HCAvatarMgr.h"

#import "HCTagAddObjectApi.h"

@interface HCTagUserDetailController ()<HCPickerViewDelegate>
@property (nonatomic,strong) HCPickerView *datePicker;
@property (nonatomic,strong) NSString *myTitle;
@property (nonatomic,strong) HCNewTagInfo *info;
@property (nonatomic,strong) UIImage *image;

@end

@implementation HCTagUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = self.data[@"title"];
    self.info = self.data[@"info"];
    self.myTitle = self.info.trueName;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    [self setupBackItem];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    if (self.info.trueName != nil) {
        item.title = @"编辑";
        self.title = [NSString stringWithFormat:@"%@的信息",self.myTitle];
    }else
    {
       item.title = @"保存";
        self.title = @"新增标签使用者";
    }
    
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }
    else
    {
        return 6;
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
    else
    {
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagUserDetailCell *cell = [HCTagUserDetailCell cellWithTableView:tableView];
    cell.info = self.data[@"info"];
    cell.image = self.image;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = kHCBackgroundColor;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 100, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"医疗急救卡";
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
    if ([item.title isEqualToString:@"保存"])
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
        
        if (self.image) {
            [self uploadImage];
        }
        
    }
    else
    {
       // 编辑按钮点击
    }
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

#pragma mark --- network

-(void)uploadImage
{
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkUser,uuid,token]];
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.info.imageName = responseObject[@"Data"][@"files"][0];
        
        [self requestData];
    } failure:^(NSError *error) {
        
    }];
    

}
-(void)requestData
{

    HCTagAddObjectApi *api = [[HCTagAddObjectApi alloc]init];
    
    api.info = self.info;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"添加标签使用者成功"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
