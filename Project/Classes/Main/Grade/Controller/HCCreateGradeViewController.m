//
//  HCCreateGradeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCreateGradeViewController.h"
#import "HCGradeSuccessViewController.h"
#import "HCAvatarMgr.h"
#import "HCCreateGradeTableViewCell.h"
#import "HCCreateGradeInfo.h"
#import "HCFooterView.h"

#import "HCImageUploadInfo.h"
#import "HCCreateGradeApi.h"

#import "NHCCreatefamilyApi.h"
#import "FamilyUploadImageApi.h"

#define HCCreateGrade @"HCCreateGrade"

@interface HCCreateGradeViewController ()<HCFooterViewDelegate>

@property (nonatomic, strong) HCCreateGradeInfo *info;

@property (nonatomic, strong) HCFooterView *footerView;
@property (nonatomic,strong) UIImage *image;

@end

@implementation HCCreateGradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"创建家庭";
    [self setupBackItem];
    
    _info = [[HCCreateGradeInfo alloc] init];
    [self.tableView registerClass:[HCCreateGradeTableViewCell class] forCellReuseIdentifier:HCCreateGrade];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCreateGradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCCreateGrade];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = _info;
    cell.indexPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4)
    {
        [HCAvatarMgr manager].noUploadImage = YES;
        [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
            if (result)
            {
                _info.uploadImage = image;
                self.image = image;
                [self.tableView reloadData];
            }
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4)
    {
        return 150;
    }
    return 50;
}

#pragma mark - HCFooterViewDelegate

- (void)hcfooterViewSelectedButton:(HCFooterViewButtonType)type
{
    if (type == HCFooterViewButtonTypeSave)
    {
        [self checkCreateGradeData];
    }else if (type == HCFooterViewButtonTypeServer)
    {
        DLog(@"服务协议");
    }else if (type == HCFooterViewButtonTypePrivacy)
    {
        DLog(@"隐私政策");
    }
}

#pragma mark - private methods

- (void)checkCreateGradeData
{
    if (IsEmpty(_info.familyNickName))
    {
        [self showHUDText:@"家庭昵称不能为空"];
        return;
    }
    if (IsEmpty(_info.familyDescription))
    {
        [self showHUDText:@"家庭签名不能为空"];
        return;
    }
    if (IsEmpty(_info.contactAddr))
    {
        [self showHUDText:@"学校地址不能为空!"];
        return;
    }
    

    [self requestCreateGrade];
}

#pragma mark - setter or getter

- (HCFooterView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[HCFooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 160)];
        _footerView.delegate = self;
    }
    return _footerView;
}

#pragma mark - network 

- (void)requestCreateGrade
{
    
    if (IsEmpty(self.image)) {
        [self showHUDText:@"请上传递家庭图片"];
        return;
    }
    if (IsEmpty(self.info.ancestralHome)) {
        [self showHUDText:@"请输入祖籍"];
        return;
    }
    if (IsEmpty(self.info.familyNickName)) {
        [self showHUDText:@"请输入家庭昵称"];
        return;
    }
    if (IsEmpty(self.info.familyDescription)) {
        [self showHUDText:@"请输入家庭签名"];
        return;
    }
    if (IsEmpty(self.info.contactAddr)) {
        [self showHUDText:@"请输入家庭住址"];
        return;
    }
    
     [self upLoadImage];
}

-(void)createFamily
{

    HCCreateGradeApi *api = [[HCCreateGradeApi alloc] init];
    api.gradeInfo = _info;
    
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            
            NSLog(@"创建家庭成功");
            NSDictionary *dic = respone[@"Data"][@"UserEntity"];
            
            _info = [HCCreateGradeInfo mj_objectWithKeyValues:dic];
            [HCAccountMgr manager].loginInfo.createFamilyId = _info.familyId;
            [HCAccountMgr manager].familyInfo = _info;
            
            [readUserInfo createFamileDic:dic];
            HCGradeSuccessViewController *finishVC = [[HCGradeSuccessViewController alloc]init];
            finishVC.data = @{@"data":_info};
            [self.navigationController pushViewController:finishVC animated:YES];
            
        }
    }];

}

-(void)upLoadImage
{
    
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkFamail,uuid,token]];
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.info.imageName = responseObject[@"Data"][@"files"][0];
        [self createFamily];
        

    } failure:^(NSError *error) {
        
    }];

}
- (void)requestImageUpload
{
    [self showHUDView:nil];
    
//    HCImageUploadApi *api = [[HCImageUploadApi alloc] init];
//    api.FTImages = @[_info.uploadImage];
//    api.fileType = @"FamilyPhoto";
//    
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            HCImageUploadInfo *info = [array lastObject];
////            _info.FamilyPhoto = info.FileUrl;
//            _info.FamilyPhoto = info.FileName;
//            [self requestCreateGrade];
//        }else
//        {
//            [self showHUDError:@"头像上传失败!"];
//        }
//    }];
}


@end
