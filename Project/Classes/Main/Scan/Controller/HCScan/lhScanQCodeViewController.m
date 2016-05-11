//
//  lhScanQCodeViewController.m
//  lhScanQCodeTest
//
//  Created by bosheng on 15/10/20.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "lhScanQCodeViewController.h"
#import "QRCodeReaderView.h"
#import "HCBindTagController.h"
#import "HCScanApi.h"
#import "HCNotificationCenterInfo.h"
#import "HCOtherPromisedDetailController.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "HCJoinGradeViewController.h"
//查询环信的个人找号
#import "NHCMessageSearchUserApi.h"
//跳转添加好友界面
#import "HCMessagePersonInfoVC.h"
//获取好友状态
#import "NHCScanUSerCodeApi.h"
#import <MAMapKit/MAMapKit.h>

#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
#define widthRate DeviceMaxWidth/320
#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)

@interface lhScanQCodeViewController ()<QRCodeReaderViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,MAMapViewDelegate,CLLocationManagerDelegate>
{
    QRCodeReaderView * readview;//二维码扫描对象 
    
    BOOL isFirst;//第一次进入该页面
    BOOL isPush;//跳转到下一级页面
    int a ;
     CLLocation *_current_location;
}
@property (nonatomic, strong)MAMapView     *mapview;
@property (strong, nonatomic) CIDetector *detector;
@property (nonatomic,strong) NSString *createLocation;

@end

@implementation lhScanQCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackItem];
    [self initMap];// 初始化地图
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    isFirst = YES;
    isPush = NO;
    
    [self InitScan];
}

#pragma mark 初始化扫描

- (void)InitScan
{
    if (readview) {
        [readview removeFromSuperview];
        readview = nil;
    }
    
    readview = [[QRCodeReaderView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, DeviceMaxHeight)];
    readview.is_AnmotionFinished = YES;
    readview.backgroundColor = [UIColor clearColor];
    readview.delegate = self;
    readview.alpha = 0.5;
    
    //添加 开灯  和读取相册
    
    
    //2.相册
    UIView *bacnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.88, SCREEN_WIDTH, SCREEN_HEIGHT *0.15)];
    UIButton * albumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake(SCREEN_WIDTH*0.2, 10, 50, 50);
    //albumBtn.center=CGPointMake(0, 100+49/2.0);
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    albumBtn.contentMode=UIViewContentModeScaleAspectFit;
    [albumBtn addTarget:self action:@selector(myAlbum) forControlEvents:UIControlEventTouchUpInside];
    [bacnView addSubview:albumBtn];
    
    //3.闪光灯
    
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(SCREEN_WIDTH*0.8-50, 10, 50, 50);
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"turn_on"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [bacnView addSubview:flashBtn];
    bacnView.backgroundColor = [UIColor darkGrayColor];
    [readview addSubview:bacnView];
    [self.view addSubview:readview];
    
    [UIView animateWithDuration:0.5 animations:^{
        readview.alpha = 1;
    }completion:^(BOOL finished) {

    }];
    
}
#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    NSLog(@"闪光灯");
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}
#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
-(void)myAlbum{
    
    NSLog(@"我的相册");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:NULL];
        
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark - 相册

- (void)alumbBtnEvent
{
    
    self.detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) { //判断设备是否支持相册
        
        if (IOS8) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未开启访问相册权限，现在去开启！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 4;
            [alert show];
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    
        return;
    }
    
    isPush = YES;
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.mediaTypes = [UIImagePickerController         availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    readview.is_Anmotion = YES;
    
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
//    if (features.count >=1) {
    
        [picker dismissViewControllerAnimated:YES completion:^{
            //检测结果数组
            
             NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            if(features.count>=1){
                CIQRCodeFeature *feature = [features objectAtIndex:0];
                NSString *scannedResult = feature.messageString;
                //播放扫描二维码的声音
                SystemSoundID soundID;
                NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
                AudioServicesPlaySystemSound(soundID);
                NSLog(@"%@",scannedResult);
                if (a ==0) {
                    [self accordingQcode:scannedResult];
                }else{
                    
                }
                
            }else{
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
                [picker dismissViewControllerAnimated:YES completion:^{
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
                    
                    readview.is_Anmotion = NO;
                    [readview start];
                }];
            }

//            CIQRCodeFeature *feature = [features objectAtIndex:0];
//            NSString *scannedResult = feature.messageString;
//            //播放扫描二维码的声音
//            SystemSoundID soundID;
//            NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
//            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//            AudioServicesPlaySystemSound(soundID);
//            if (a ==0) {
//                  [self accordingQcode:scannedResult];
//            }else{
//                
//            }
            
          
        }];
        
    }
//    else{
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        [picker dismissViewControllerAnimated:YES completion:^{
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//            
//            readview.is_Anmotion = NO;
//            [readview start];
//        }];
//    }


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
    
}

#pragma mark -QRCodeReaderViewDelegate
- (void)readerScanResult:(NSString *)result
{
    readview.is_Anmotion = YES;
    [readview stop];
    
    //播放扫描二维码的声音
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [self accordingQcode:result];
    
    [self performSelector:@selector(reStartScan) withObject:nil afterDelay:1.5];
}

#pragma mark - 扫描结果处理
- (void)accordingQcode:(NSString *)str
{

    NSString * frist_str = [str substringToIndex:1];
    if ([frist_str isEqualToString:@"U"]) {
        //扫码添加好友
        NHCScanUSerCodeApi *api_1 = [[NHCScanUSerCodeApi alloc]init];
        api_1.userID = str;
        [api_1 startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            // 0: 未添加，1：已添加，2：等待对方验证，3：等待自己验证
            if ([responseObject isEqualToString:@"0"]) {
                NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
                api.UserChatID = str;
                [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *model) {
                    if (requestStatus==10018) {
                        [self showHUDSuccess:@"您添加的好友不存在"];
                    }else if (requestStatus==100){
                        HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
                        NSMutableArray *arr = [NSMutableArray array];
                        [arr addObject:model];
                        vc.dataSource  = arr;
                        vc.ChatId = model.NickName;
                        vc.ScanCode = YES;
                        vc.userInfo = model;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
//                [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chatUserName) {
//                    if (requestStatus==10018) {
//                        [self showHUDSuccess:@"您添加的好友不存在"];
//                    }else if (requestStatus==100){
//                        HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
//                        NSMutableArray *arr = [NSMutableArray array];
//                        [arr addObject:chatUserName];
//                        vc.dataSource  = arr;
//                        vc.ChatId = chatUserName;
//                        vc.ScanCode = YES;
//                        [self.navigationController pushViewController:vc animated:YES];
//                    }
//                }];
            }else if ([responseObject isEqualToString:@"1"]){
                [self showHUDSuccess:@"您已经添加过该好友"];
                //显示好友的详细信息
                
            }else if([responseObject isEqualToString:@"2"]){
                [self showHUDSuccess:@"您已经发送过好友请求"];
                //显示缩略信息
            }else{
                
            }
  
        }];

    }else if ([frist_str isEqualToString:@"M"]){
        //判断标签是否激活
        
        
        
        //没有激活是下面的操作
        HCBindTagController *bindVC = [[HCBindTagController alloc]init];
        bindVC.labelGuid = str;
        [self.navigationController pushViewController:bindVC animated:YES];
    }else if ([frist_str isEqualToString:@"F"]){
        
        if (_isJoinFamily)
        {
            self.block(str);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            HCJoinGradeViewController *JoinFamilyVC = [[HCJoinGradeViewController alloc]init];
            JoinFamilyVC.familyID = str;
            [self.navigationController pushViewController:JoinFamilyVC animated:YES];
        }

    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        HCScanApi *api = [[HCScanApi alloc]init];
        api.labelGuid = str;
        api.createLocation = self.createLocation;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
            if (requestStatus == HCRequestStatusSuccess) {
                NSDictionary *dic = respone[@"Data"][@"labelInf"];
                HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
                HCOtherPromisedDetailController *vc = [[HCOtherPromisedDetailController alloc]init];
                vc.data = @{@"info":info};
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }];
    }
    a = 1;
//    if (str.length==10) { //------------------家庭号码-----------------
//        
//        
//        if (_isJoinFamily)
//        {
//            self.block(str);
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            HCJoinGradeViewController *JoinFamilyVC = [[HCJoinGradeViewController alloc]init];
//            JoinFamilyVC.familyID = str;
//            [self.navigationController pushViewController:JoinFamilyVC animated:YES];
//        }
//    }else if (_isAddFr){
//        //扫码添加好友
//        NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
//        api.UserChatID = str;
//        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chatUserName) {
//            HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
//            NSMutableArray *arr = [NSMutableArray array];
//            [arr addObject:chatUserName];
//            vc.dataSource  = arr;
//            vc.ChatId = chatUserName;
//            vc.ScanCode = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }];
//    }
//    else
//    {
//        if (_isActive) { // ----------------标签GUID------------
//            HCBindTagController *bindVC = [[HCBindTagController alloc]init];
//            bindVC.labelGuid = str;
//            [self.navigationController pushViewController:bindVC animated:YES];
//        }
//        else
//        {
//            HCScanApi *api = [[HCScanApi alloc]init];
//            api.labelGuid = str;
//            api.createLocation = self.createLocation;
//            [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
//                if (requestStatus == HCRequestStatusSuccess) {
//                    NSDictionary *dic = respone[@"Data"][@"labelInf"];
//                    HCNotificationCenterInfo *info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
//                    HCOtherPromisedDetailController *vc = [[HCOtherPromisedDetailController alloc]init];
//                    vc.data = @{@"info":info};
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                
//            }];
//          
//        }
//    }
//    

}

- (void)reStartScan
{
    readview.is_Anmotion = NO;
    
    if (readview.is_AnmotionFinished) {
        [readview loopDrawLine];
    }
    
    [readview start];
}


#pragma mark - view
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isFirst || isPush) {
        if (readview) {
            [self reStartScan];
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (readview) {
        [readview stop];
        readview.is_Anmotion = YES;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (isFirst) {
        isFirst = NO;
    }
    if (isPush) {
        isPush = NO;
    }
}

// ------------初始化地图--------------------
-(void)initMap
{
    
    [MAMapServices sharedServices].apiKey =@"20e897d0e7d653770541a040a12065d8";
    _mapview = [[MAMapView alloc]init];
    _mapview.userTrackingMode = 1;
    _mapview.delegate = self;
    _mapview.showsUserLocation = YES;
}


#pragma mark 当前经纬度的坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    NSLog(@"user_location ==%@",userLocation.location);
    _current_location =[userLocation.location copy];
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        self.createLocation = [NSString  stringWithFormat:@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude];
    }
    
}

@end
