
//
//  HCJoinGradeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCJoinGradeViewController.h"
#import "lhScanQCodeViewController.h"
#import "HCFamilyMessageViewController.h"
#import "HCJoinGradeFunctionView.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "applyToFamily.h"
#import "findFamilyMessage.h"
#import "HCCreateGradeInfo.h"

#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)

@interface HCJoinGradeViewController ()<HCJoinGradeFunctionViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) UITextField *textField1;

@property (nonatomic, strong) NSString *gradeId;

@property (nonatomic, strong) HCJoinGradeFunctionView *rightFunctionView;
@property (nonatomic, strong) lhScanQCodeViewController *lhScanVC;

@property (strong, nonatomic) CIDetector *detector;

@end

@implementation HCJoinGradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"加入家庭";
    [self setupBackItem];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    [self.view addSubview:self.rightFunctionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rightFunctionView.hidden = YES;
    self.rightItem.tag = 0;
}

#pragma UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"joingrade"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"家庭ID";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:self.textField];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"joingrade"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"验证信息";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:self.textField1];
        
        return cell;
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 100)];
    [footer addSubview:self.joinButton];
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - HCJoinGradeFunctionViewDelegate

- (void)hcjoinGradeFunctionViewSelectedType:(HCJoinGradeFunctionViewButtonStype)type
{
    
    if (type == HCJoinGradeFunctionViewButtonStypeScan)
    {
        _lhScanVC= [[lhScanQCodeViewController alloc]init];
        [self.navigationController pushViewController:_lhScanVC animated:YES];
    }else if (type == HCJoinGradeFunctionViewButtonStypeJoin)
    {
        [self alumbBtnEvent];
    }
}

#pragma mark - 相册扫描二维码

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
            
            [self accordingQcode:scannedResult];
        }];
        
    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

#pragma mark - 扫描结果处理
- (void)accordingQcode:(NSString *)str
{
#warning 得到班级ID信息，进行网络请求加入默认班级，然后进入时光主页
    [self requestJoinGrade];
}

#pragma mark - private methods

// 点击右边扫描二维码的Item
- (void)handleRightItem:(UIBarButtonItem *)item
{
//    self.rightFunctionView.hidden = item.tag;
//    item.tag = !item.tag;
    
    _lhScanVC= [[lhScanQCodeViewController alloc]init];
    [self.navigationController pushViewController:_lhScanVC animated:YES];
    
}

// --------------------------点击了完成按钮-----------------------
- (void)handleJoinButton
{
    if (IsEmpty(self.textField.text))
    {
        [self showHUDText:@"请输入家庭ID号"];
        return;
    }
    
    [self requestJoinGrade];
}

- (void)toHomeViewController
{
    // 请求成功后，进入时光主页
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.showWelcomeJoinGradeID = _gradeId;
    [app setupRootViewController];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem:)];
    }
    return _rightItem;
}

- (HCJoinGradeFunctionView *)rightFunctionView
{
    if (!_rightFunctionView)
    {
        _rightFunctionView = [[HCJoinGradeFunctionView alloc] initWithFrame:CGRectMake(WIDTH(self.view)-125, -13, 120, 120)];
        _rightFunctionView.tag = 1;
        _rightFunctionView.delegate = self;
    }
    return _rightFunctionView;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, WIDTH(self.view)-80, 47)];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.placeholder = @"请点击输入家庭ID号";
    }
    return _textField;
}

- (UITextField *)textField1
{
    if (!_textField1)
    {
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, WIDTH(self.view)-80, 47)];
        _textField1.font = [UIFont systemFontOfSize:15];
        _textField1.placeholder = @"请点击输入验证信息";
    }
    return _textField1;
}

- (UIButton *)joinButton
{
    if (!_joinButton)
    {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinButton.frame = CGRectMake(15, 30, WIDTH(self.view)-30, 44);
        [_joinButton setTitle:@"完成" forState:UIControlStateNormal];
        _joinButton.backgroundColor = RGB(251, 25, 53);
        [_joinButton addTarget:self action:@selector(handleJoinButton) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_joinButton, 4);
    }
    return _joinButton;
}


#pragma mark - network

- (void)requestJoinGrade
{
    
    findFamilyMessage *api = [[findFamilyMessage alloc]init];
    api.familyId =self.textField.text;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess) {
            
            
            NSDictionary *dic = respone[@"Data"][@"FamilyInf"];
            HCCreateGradeInfo *info = [[HCCreateGradeInfo alloc]init];
            info.familyId = dic[@"familyId"];
            info.ancestralHome = dic[@"ancestralHome"];
            info.familyNickName = dic[@"familyNickName"];
            info.familyPhoto = dic[@"familyPhoto"];
            info.contactAddr = dic[@"contactAddr"];
            
            HCFamilyMessageViewController *familyMessageVC = [[HCFamilyMessageViewController alloc]init];
            familyMessageVC.data = @{@"info":info,@"message":self.textField1.text};
            [self.navigationController pushViewController:familyMessageVC animated:YES];
            
        }
        
    }];

//    _gradeId = gradeId;
//    [self performSelector:@selector(toHomeViewController) withObject:nil afterDelay:1.2];
}


@end
