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
//地图
#import <MAMapKit/MAMapKit.h>

#define HCPublishCell @"HCPublishCell"

@interface HCPublishViewController ()<ACEExpandableTableViewDelegate, HCPublishTableViewCellDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HCJurisdictionVCDelegate,MAMapViewDelegate>{
    int a ;

}

@property (nonatomic, strong) HCPublishInfo *info;
@property (nonatomic, strong) UIBarButtonItem *publishBtnItem;
@property (nonatomic, assign) CGFloat editHeight;
@property (nonatomic, strong) UIImageView *backgrand;
@property (nonatomic, strong) NSMutableArray *uploadImageNameArr;
@property (nonatomic, strong) MAMapView *mapview;
@property (nonatomic, strong) CLLocation *current_location;

@property(nonatomic,copy)NSString *createLocation;
@property(nonatomic,copy)NSString *createAddrSmall;
@property(nonatomic,copy)NSString *createAddr;

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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapIsTure) name:@"createMap"  object:nil];
    [self CreatMap];
}
//- (void)mapIsTure{
//    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
//}
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
        publishCell.detailTextLabel.tag = 1000;
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
    UILabel *label = [self.view viewWithTag:1000];
    label.text = _info.PermitType;
    if([_info.PermitType isEqualToString:@"100"]){
        label.text = @"所有人可见";
    }else{
        label.text = @"仅自己可见";
    }
    
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
                
                if (IsEmpty(str1)) {
                    [self showHUDView:@"上传ttupian"];
                }else{
                    
                }
                
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
                    //发表文字 图片时光
                    NHCReleaseTimeApi *api = [[NHCReleaseTimeApi alloc]init];
                    api.content = _info.FTContent;
                    api.openAddress = _info.OpenAddress;
                    api.imageNames = str_all;
                    api.createAddr = _createAddr;
                    api.createLocation = _createLocation;
                    api.createAddrSmall = _createAddrSmall;
                    //判断权限类型
                    if (IsEmpty(_info.PermitType)) {
                        api.permitType = @"0";
                    }else{
                        if ([_info.PermitType isEqualToString:@"100"]) {
                            api.permitType = @"0";
                        }else if([_info.PermitType isEqualToString:@"101"]){
                            api.permitType = @"2";
                        }
                    }
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
        if (IsEmpty(_createAddr)) {
            api.createAddr = @"上海市，闵行区，集心路168号";
            api.createLocation = @"31.0123,121.0101";
            api.createAddrSmall = @"上海市，闵行区";
            
        }else{
            api.createAddr = _createAddr;
            api.createLocation = _createLocation;
            api.createAddrSmall = _createAddrSmall;
        }
        
        if (IsEmpty(_info.PermitType)) {
            api.permitType = @"0";
        }else{
            if ([_info.PermitType isEqualToString:@"100"]) {
                api.permitType = @"0";
            }else if([_info.PermitType isEqualToString:@"101"]){
                api.permitType = @"2";
            }
        }
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
#pragma mark  创建地图
//打开创建
- (void)CreatMap{ 
        [MAMapServices sharedServices].apiKey =@"20e897d0e7d653770541a040a12065d8";
        _mapview = [[MAMapView alloc]init];
        _mapview.userTrackingMode = 0;
        _mapview.delegate = self;
        _mapview.showsUserLocation = YES;
}
//定位返回信息的回调代理
#pragma mark 当前经纬度的坐标


//定位
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [self encoded:userLocation];
}

//反地理编码
- (void)encoded:(MAUserLocation *)sender
{
    CLLocation *location = [[CLLocation alloc]initWithLatitude:sender.location.coordinate.latitude longitude:sender.location.coordinate.longitude];
    //经纬度
    _createLocation = [NSString stringWithFormat:@"%f,%f",sender.location.coordinate.latitude,sender.location.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSDictionary *dict = placemark.addressDictionary;
            //jiedao
            NSString *streetStr = [dict objectForKey:@"Street"];
            //区
            NSString *countyStr = [dict objectForKey:@"SubLocality"];
            //街道暂时
            NSString *street = [countyStr stringByAppendingString:streetStr];
            NSLog(@"street address: %@",[dict objectForKey:@"Street"]);
            //城市
            NSString *city = placemark.locality;
           
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@",city);
            _createAddrSmall = [NSString stringWithFormat:@"%@,%@",city,countyStr];
            _createAddr = [NSString stringWithFormat:@"%@,%@",city,street];
            
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        _mapview.showsUserLocation = NO;
        
    }];
}

@end
