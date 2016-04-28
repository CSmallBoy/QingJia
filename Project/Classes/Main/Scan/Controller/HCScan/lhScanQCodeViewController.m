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
    readview.alpha = 0;
    
    
    [self.view addSubview:readview];
    
    [UIView animateWithDuration:0.5 animations:^{
        readview.alpha = 1;
    }completion:^(BOOL finished) {

    }];
    
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
    
    NSArray *features = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >=1) {
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            //播放扫描二维码的声音
            SystemSoundID soundID;
            NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
            AudioServicesPlaySystemSound(soundID);
            if (a ==0) {
                  [self accordingQcode:scannedResult];
            }else{
                
            }
            
          
        }];
        
    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            
            readview.is_Anmotion = NO;
            [readview start];
        }];
    }
}

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
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
    a = 1;
    if (str.length==10) { //------------------家庭号码-----------------
        
        
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
    }else if (_isAddFr){
        //扫码添加好友
        NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
        api.UserChatID = str;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chatUserName) {
            HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:chatUserName];
            vc.dataSource  = arr;
            vc.ChatId = chatUserName;
            vc.ScanCode = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    else
    {
    
        if (_isActive) { // ----------------标签GUID------------
            
            
            HCBindTagController *bindVC = [[HCBindTagController alloc]init];
            bindVC.labelGuid = str;
            [self.navigationController pushViewController:bindVC animated:YES];
        }
        else
        {
           
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
    }
    

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
