//
//  HCPublishViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPublishViewController.h"
#import "HCJurisdictionViewController.h"
#import "HCHomePublishApi.h"
#import "HCPublishTableViewCell.h"
#import "ACEExpandableTextCell.h"
#import "HCPublishInfo.h"
#import "NHCReleaseTimeApi.h"
//多图
#import "NHCUploadImageMangApi.h"
//获取时光列表
#import "NHCListOfTimeAPi.h"
//获取时光多图
#import "NHCDownLoadManyApi.h"
#import "KLHttpTool.h"
//时光
#import "HCHomeViewController.h"
//多图片选择
#import "ZLPhotoAssets.h"
#import "ZLPhotoPickerViewController.h"
//测试省市县
#import "NHCRegionApi.h"
#define HCPublishCell @"HCPublishCell"

@interface HCPublishViewController ()<ACEExpandableTableViewDelegate, HCPublishTableViewCellDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HCJurisdictionVCDelegate>{
    int a ;
}

@property (nonatomic, strong) HCPublishInfo *info;
@property (nonatomic, strong) UIBarButtonItem *publishBtnItem;
@property (nonatomic, assign) CGFloat editHeight;
@property (nonatomic, strong)UIImageView *backgrand;

@property (nonatomic, strong) NSMutableArray *uploadImageNameArr;

@end

@implementation HCPublishViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发布消息";
    [self setupBackItem];
    
    self.navigationItem.rightBarButtonItem =self.publishBtnItem;
    _info = [[HCPublishInfo alloc] init];
    _info.OpenAddress = @"1";
    _info.PermitType = @"100";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HCPublishTableViewCell class] forCellReuseIdentifier:HCPublishCell];
    //验证地区
//    NHCRegionApi * api  = [[NHCRegionApi alloc]init];
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
//        
//    }];
   
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        ACEExpandableTextCell *textCell = [tableView expandableTextCellWithId:@"editcell"];
        textCell.textView.placeholder = @"发表些心情吧...";
        textCell.textView.font = [UIFont systemFontOfSize:15];
        cell = textCell;
    }else
    {
        HCPublishTableViewCell *publishCell = [tableView dequeueReusableCellWithIdentifier:HCPublishCell];
        publishCell.delegate = self;
        publishCell.info = _info;
        publishCell.indexPath = indexPath;
        cell = publishCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
    {
        HCJurisdictionViewController *jurisdictionVC = [[HCJurisdictionViewController alloc] init];
        jurisdictionVC.delegate = self;
        [self.navigationController pushViewController:jurisdictionVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section) ? 1 : 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 46;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return MAX(80, _editHeight);
    }else if (indexPath.row == 1)
    {
        NSInteger rows = _info.FTImages.count / 3;
        rows += (_info.FTImages.count%3) ? 1 : 0;
        return (WIDTH(self.view)/3) *MIN(rows, 3);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - HCJurisdictionVCDelegate

- (void)hcJurisdictionViewControllerWithPermitType:(NSString *)PermitType permitUserArr:(NSMutableArray *)permitUserArr
{
    _info.PermitType = PermitType;
    _info.PermitUserArr = permitUserArr;
}

#pragma mark - HCPublishTableViewCellDelegate

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (_info.FTImages.count == index)
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [action showInView:self.view];
    }
}

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index
{
    [_info.FTImages removeObjectAtIndex:index-1];
    [self.tableView reloadData];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) // 拍照
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (buttonIndex == 1) // 相册
    {
        
        ZLPhotoPickerViewController *vc = [[ZLPhotoPickerViewController alloc]init];
        vc.callBack = ^(NSArray *arr){
            
            if (_info.FTImages.count >= 10)
            {
                [self showHUDText:@"最多只能发布9张图片"];
                return;
            }else{
                for (ZLPhotoAssets *pho in arr) {
                    UIImage *image = pho.originImage;
                    [_info.FTImages insertObject:image atIndex:_info.FTImages.count - 1];
                }
                [self.tableView reloadData];
            }
        };
        [self presentViewController:vc animated:YES completion:^{
            
        }];
        
    }
}

//- (UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
//    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
//    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
//    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return reSizeImage;
//}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{//不编辑图片
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_info.FTImages.count >= 10)
    {
        [self showHUDText:@"最多只能发布9张图片"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [_info.FTImages insertObject:image atIndex:_info.FTImages.count-1];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ACEExpandableTableViewDelegate

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _editHeight = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    _info.FTContent= text;
}

#pragma mark - private methods

- (void)handlePublishBarButtonItem
{
    if (IsEmpty(_info.FTContent))
    {
        [self showHUDText:@"发布内容不能为空"];
        return;
    }
    if (a == 1) {
        
    }else{
        a = 1;
        [self  requestPublistData];
    }
    
}

#pragma mark - setter or getter

- (UIBarButtonItem *)publishBtnItem
{
    if (!_publishBtnItem)
    {
        _publishBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(handlePublishBarButtonItem)];
    }
    return _publishBtnItem;
}

#pragma mark - network

- (void)requestPublistData
{   //没有图片发布时走这个
    if (_info.FTImages.count>1) {
        NSMutableArray *arr_image_path = [NSMutableArray array];
        // 先上传 图片  在发布时光  获取到图片的名字  放入数组中  主线程
        NSString *str = [readUserInfo url:kkTimes];
        for (int i = 0 ; i < _info.FTImages.count-1 ; i ++) {
            [KLHttpTool uploadImageWithUrl:str image:_info.FTImages[i] success:^(id responseObject) {
                [self showHUDView:@"发表中..."];
                NSString *str1 = responseObject[@"Data"][@"files"][0];
                [arr_image_path addObject:str1];
                NSString *str2;
                NSString *str_all = [NSMutableString string];
                if (arr_image_path.count == _info.FTImages.count-1) {
                    for (int i = 0 ; i < arr_image_path.count ; i ++) {
                        if (i == 0) {
                            str2 = arr_image_path[0];
                            str_all = [str2 stringByAppendingString:str_all];
                        }else{
                            str2 = [arr_image_path[i] stringByAppendingString:@","];
                            str_all = [str2 stringByAppendingString:str_all];
                        }
                    }
                    //发表文字时光
                    NHCReleaseTimeApi *api = [[NHCReleaseTimeApi alloc]init];
                    api.content = _info.FTContent;
                    api.openAddress = _info.OpenAddress;
                    api.imageNames = str_all;
                    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *Tid) {
                        [self hideHUDView];
                        for (UIViewController *temp in self.navigationController.viewControllers) {
                            if ([temp isKindOfClass:[HCHomeViewController class]])
                            {
                                [self.navigationController popToViewController:temp animated:YES];
                            }
                        }
                    }];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }else{
        //发表文字时光
        NHCReleaseTimeApi *api = [[NHCReleaseTimeApi alloc]init];
        api.content = _info.FTContent;
        api.openAddress = _info.OpenAddress;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *Tid) {
            
            [self hideHUDView];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[HCHomeViewController class]])
                {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }];
    }
    
}





////多图上传
- (void)uploadManyImage:(NSString*)Tid{
    //将数组中的图片  变成字符串
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < _info.FTImages.count -1; i ++) {
        NSString *str = [readUserInfo imageString:_info.FTImages[i]];
        [arr addObject:str];
    }
    NSString *str_all = [NSMutableString string];
    NSString *str2 ;
    for (int i = 0 ; i < arr.count ; i ++) {
        if (i == 0) {
            str2 = arr[0];
            str_all = [str2 stringByAppendingString:str_all];
        }else{
            str2 = [arr[i] stringByAppendingString:@"#*,*#"];
            str_all = [str2 stringByAppendingString:str_all];
        }
    }
    //NSLog(@"%@",str_all);
    NHCUploadImageMangApi *api = [[NHCUploadImageMangApi alloc]init];
    api.TimeID = Tid;
    api.photoStr = str_all;
    api.type = @"6";
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        
    }];
}
@end
