//
//  Scan_VC.m
//  仿支付宝
//
//  Created by 张国兵 on 15/12/9.
//  Copyright © 2015年 zhangguobing. All rights reserved.

#import "Scan_VC.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+SDExtension.h"
#import "HCeditingViewController.h"


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
//标签状态
#import "NHCLabelStateApi.h"

#import <MAMapKit/MAMapKit.h>
//已激活->标签详情
#import "HCTagManagerDetailViewController.h"
//已发呼->一呼百应详情(别人的,自己的)
#import "HCMyPromisedDetailController.h"
#import "HCOtherPromisedDetailController.h"
//已停用->提示已停用
//无效->提示无效
//定位
#import <AMapLocationKit/AMapLocationKit.h>
//扫描已发呼的标签
#import "HCScanCardApi.h"


static const CGFloat kBorderW = 100;
static const CGFloat kMargin = 30;
@interface Scan_VC ()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,AMapLocationManagerDelegate>{
    UIImagePickerController *controller;
    
}
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak)   UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIImageView *scanNetImageView;

@property (nonatomic,strong) AMapLocationManager *locationManager;//定位

@property (nonatomic,copy)NSString *locationStr;
@end

@implementation Scan_VC
-(void)viewWillAppear:(BOOL)animated{
    
    //self.navigationController.navigationBar.hidden=YES;
    [_session startRunning];
    [self locationButtonAction];
    [self resumeAnimation];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
   // self.navigationController.navigationBar.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //这个属性必须打开否则返回的时候会出现黑边
    self.view.clipsToBounds=YES;
    //1.遮罩
    [self setupMaskView];
    //2.下边栏
    [self setupBottomBar];
    //3.提示文本
    [self setupTipTitleView];
    //4.顶部导航
    [self setupNavView];
    //5.扫描区域
    [self setupScanWindowView];
    //6.开始动画
    [self beginScanning];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resumeAnimation) name:@"EnterForeground" object:nil];
}
-(void)button_next{
    HCeditingViewController *VC= [[HCeditingViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)setupTipTitleView{
    
    //1.补充遮罩
    UIView*mask=[[UIView alloc]initWithFrame:CGRectMake(0, _maskView.sd_y+_maskView.sd_height, self.view.sd_width, kBorderW)];
    mask.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask];
    //2.操作提示
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.sd_height*0.9-kBorderW*2, self.view.bounds.size.width, kBorderW)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
}
-(void)setupNavView{
    
    //1.返回
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 30, 25, 25);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    //backBtn.backgroundColor = [UIColor redColor];
   [backBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    backBtn.contentMode=UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //2.相册
    UIView *bacnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.88, SCREEN_WIDTH, SCREEN_HEIGHT *0.15)];
    UIButton * albumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake(SCREEN_WIDTH*0.2, 10, 50, 50);
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
    [self.view addSubview:bacnView];

}
- (void)setupMaskView
{
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;
    
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    
    mask.bounds = CGRectMake(0, 0, self.view.sd_width + kBorderW + kMargin , self.view.sd_width + kBorderW + kMargin);
    mask.center = CGPointMake(self.view.sd_width * 0.5, self.view.sd_height * 0.5);
    mask.sd_y = 0;
    
    [self.view addSubview:mask];
}

- (void)setupBottomBar

{
    //1.下边栏
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.sd_height * 0.9, self.view.sd_width, self.view.sd_height * 0.1)];
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    [self.view addSubview:bottomBar];
    
    //2.我的二维码
    UIButton * myCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    myCodeBtn.frame = CGRectMake(0,0, self.view.sd_height * 0.1*35/49, self.view.sd_height * 0.1);
    myCodeBtn.center=CGPointMake(self.view.sd_width/2, self.view.sd_height * 0.1/2);
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateNormal];
 
    myCodeBtn.contentMode=UIViewContentModeScaleAspectFit;
    
    [myCodeBtn addTarget:self action:@selector(myCode) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:myCodeBtn];
    
   
}
- (void)setupScanWindowView
{
    CGFloat scanWindowH = self.view.sd_width - kMargin * 2;
    CGFloat scanWindowW = self.view.sd_width - kMargin * 2;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kBorderW, scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    CGFloat buttonWH = 18;
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.sd_x, bottomLeft.sd_y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}

- (void)beginScanning
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input)
        return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
     output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSString *Str = metadataObject.stringValue;
        [self accordingQcode:Str];
    }
}
#pragma mark-> 我的相册
-(void)myAlbum{
    
    NSLog(@"我的相册");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        controller = [[UIImagePickerController alloc] init];
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
#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker==controller) {
        //1.获取选择的图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //2.初始化一个监测器
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            //监测到的结果数组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
            if (features.count >=1) {
                /**结果对象 */
                CIQRCodeFeature *feature = [features objectAtIndex:0];
                NSString *scannedResult = feature.messageString;
                [self accordingQcode:scannedResult];
                
            }
            else{
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
            
            
        }];
    }
  
    
    
}
#pragma mark - 扫描结果处理

- (void)accordingQcode:(NSString *)str
{
    
    NSString * frist_str = [str substringToIndex:1];
    NSString * label_str = [str substringToIndex:4];
    if ([frist_str isEqualToString:@"U"]) {
        //扫码添加好友
        __block HCMessagePersonInfoVC *vc = [[HCMessagePersonInfoVC alloc]init];
        NHCScanUSerCodeApi *api_1 = [[NHCScanUSerCodeApi alloc]init];
        api_1.userID = str;
        [api_1 startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            // 0: 未添加，1：已添加，2：等待对方验证，3：等待自己验证
            if ([responseObject isEqualToString:@"0"]) {
                NHCMessageSearchUserApi *api = [[NHCMessageSearchUserApi alloc]init];
                api.UserChatID = str;
                [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *model) {
                    if (requestStatus==10018) {
//                        [self showHUDSuccess:@"您添加的好友不存在"];
                    }else if (requestStatus==100){
                        //vc = [[HCMessagePersonInfoVC alloc]init];
                        NSMutableArray *arr = [NSMutableArray array];
                        [arr addObject:model];
                        vc.dataSource  = arr;
                        vc.ChatId = model.NickName;
                        vc.ScanCode = YES;
                        vc.userInfo = model;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }else if ([responseObject isEqualToString:@"1"]){
//                [self showHUDSuccess:@"您已经添加过该好友"];
                //显示好友的详细信息
                
            }else if([responseObject isEqualToString:@"2"]){
//                [self showHUDSuccess:@"您已经发送过好友请求"];
                [self showHint:@"您已经发送过好友请求"];
                //显示缩略信息
            }else{
                
            }
            
        }];
        
    }else if ([label_str isEqualToString:@"http"]){
        //判断标签是否激活
        
        NHCLabelStateApi *api = [[NHCLabelStateApi alloc]init];
        NSString *label_id = [str substringFromIndex:[str rangeOfString:@"="].location + 1];
        api.resultStr = label_id;
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            // 0:未激活，1：激活，2：激活（标签拥有者）3：呼，4：呼（标签拥有者），5：停用，6：停用（标签拥有者），7：无效
            NSString *status = responseObject[@"Data"][@"labelInf"][@"status"];
            NSString *labelId = responseObject[@"Data"][@"labelInf"][@"labelId"];
            NSString *callId = responseObject[@"Data"][@"labelInf"][@"callId"];
            if ([status isEqualToString:@"0"])
            {
                //没有激活是下面的操作
                HCBindTagController *bindVC = [[HCBindTagController alloc]init];
                bindVC.labelGuid = label_id;
                [self.navigationController pushViewController:bindVC animated:YES];
            }
            else if ([status isEqualToString:@"1"] || [status isEqualToString:@"2"])
            {
                HCTagManagerDetailViewController *tagDetailVC = [[HCTagManagerDetailViewController alloc] init];
                tagDetailVC.tagID = labelId;
                [self.navigationController pushViewController:tagDetailVC animated:YES];
            }
            else if ([status isEqualToString:@"5"] || [status isEqualToString:@"6"])
            {
//                [self showHUDText:@"该标签已经停用"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"二维码信息" message:@"已经停用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
            else if ([status isEqualToString:@"3"] || [status isEqualToString:@"4"])
            {
                if ([status isEqualToString:@"3"])
                {
                    HCScanCardApi *scanApi = [[HCScanCardApi alloc] init];
                    scanApi.labelGuid = label_id;
                    scanApi.createLocation = self.locationStr;
                    [scanApi startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
                        
                    }];
                    
                    HCOtherPromisedDetailController *detailVC = [[HCOtherPromisedDetailController alloc] init];
                    detailVC.callId = callId;
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
                else
                {
                    HCMyPromisedDetailController *detailVC = [[HCMyPromisedDetailController alloc] init];
                    detailVC.callId = callId;
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
            }
            else
            {
//                [self showHUDText:@"其他信息"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"二维码信息" message:@"无效" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
        
        
    }else if ([frist_str isEqualToString:@"F"]){

            HCJoinGradeViewController *JoinFamilyVC = [[HCJoinGradeViewController alloc]init];
            JoinFamilyVC.familyID = str;
            [self.navigationController pushViewController:JoinFamilyVC animated:YES];
        
    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
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
#pragma mark-> 我的二维码
-(void)myCode{
    
    NSLog(@"我的二维码");
//    ViewController2*vc=[[ViewController2 alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
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


#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.view.sd_width - kMargin * 2;
        CGFloat scanNetImageViewW = _scanWindow.sd_width;
    
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
    }
    
    

}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
#pragma mark-> 返回
- (void)disMiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self disMiss];
    } else if (buttonIndex == 1) {
        [_session startRunning];
    }
}

#pragma mark - Location
- (void)locationButtonAction
{
    self.locationStr = @"位置保密";
    //先判断是否有定位权限
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务已关闭,请在设置\"隐私\"中开启定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alertView show];
    }
    else
    {
        self.locationManager = [[AMapLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //    self.textField2.text = @"上海市闵行区集心路37号";
    self.locationStr = @"位置保密";
    //    self.nowLocation = [[CLLocation alloc] initWithLatitude:31.232 longitude:37.2242];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!IsEmpty(placemarks))
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            self.locationStr = placemark.name;
            //            self.nowLocation = location;
            //            self.cityStr = placemark.locality;
        }
    }];
    [self.locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
