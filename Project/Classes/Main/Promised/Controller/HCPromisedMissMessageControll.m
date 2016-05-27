//
//  HCPromisedMissMessageControll.m
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//---------------------走失信息填写--------------------

#import "HCPromisedMissMessageControll.h"
#import "HCPromisedSendApi.h"
#import "HCAvatarMgr.h"
#import "HCPickerView.h"
#import <MAMapKit/MAMapKit.h>
//选择照片
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
//发送中
#import "HCRadarTwinkleViewController.h"

@interface HCPromisedMissMessageControll ()<UITextViewDelegate,HCPickerViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MAMapViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITextField *textField1;
@property (nonatomic,strong) UITextField *textField2;
@property (nonatomic,strong) UITextView  *textView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong)  UIImageView *bigView ;
@property (nonatomic,strong) NSString *imgStr;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) HCPickerView *datePicker;

@property (nonatomic,strong) NSString *timeStr;
@property (nonatomic,strong) NSString *AdressStr;
@property (nonatomic,strong) NSString *DscStr;


@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)UITextField *streetTextField;//街道
@property (nonatomic, strong)UIPickerView *cityPickerView;//城市选择器
@property (nonatomic, strong)UIToolbar *toolbar;//选择器的工具栏
@property (nonatomic, strong)UIView *cityView;
@property (nonatomic, strong)NSMutableArray *allCitys;//所有的城市
@property (nonatomic, copy)NSString *cityString;//已选城市名称
@property (nonatomic, copy)NSString *streetString;//已定位街道的名称
@property (nonatomic, strong)CLLocation *nowLocation;//当前经纬度
@property (nonatomic, strong)MAMapView *mapview;//地图

@property (nonatomic, assign)BOOL isShowCity;//弹出城市选择器
@property (nonatomic, assign)BOOL isShowDate;//弹出时间选择器

@property (nonatomic, strong)UIButton *commitButton;//提交按钮

@property (nonatomic, strong)NSMutableArray *imageArr;//图片数组

@end

@implementation HCPromisedMissMessageControll

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"走失信息填写";
    self.cityString = @"";
    self.streetString = @"";
    _isShowCity = NO;
    _isShowDate = NO;
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //添加提交按钮
    [self.view addSubview:self.commitButton];
    //监测时间选择器的弹出和取消
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeDatePicker) name:@"removeDatePicker" object:nil];
}

#pragma mark --- lazyLoading

//提交按钮
- (UIButton *)commitButton
{
    if (_commitButton == nil)
    {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(10, SCREEN_HEIGHT-50, SCREEN_WIDTH-20, 40) ;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:kHCNavBarColor];
        [_commitButton addTarget:self action:@selector(sendRequestData) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewRadius(_commitButton, 5);
    }
    return _commitButton;
}

- (HCPickerView *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.backgroundColor = RGB(237, 237, 237);
        [_datePicker setPickViewColer:RGB(237, 237, 237)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UIPickerView *)cityPickerView
{
    if (_cityPickerView == nil)
    {
        _cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 180/668.0*SCREEN_HEIGHT)];
        _cityPickerView.backgroundColor = RGB(237, 237, 237);
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
    }
    return _cityPickerView;
}

- (UIToolbar *)toolbar
{
    if (_toolbar == nil)
    {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
        UIBarButtonItem *sureButton = [[UIBarButtonItem alloc] initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonAction)];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:NULL];
        _toolbar.items = @[cancelButton,spaceButton,sureButton];
        
    }
    return _toolbar;
}

- (UIView *)cityView
{
    if (_cityView == nil)
    {
        _cityView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 220/668.0*SCREEN_HEIGHT)];
        _cityView.backgroundColor = [UIColor whiteColor];
        [_cityView addSubview:self.toolbar];
        [_cityView addSubview:self.cityPickerView];
    }
    return _cityView;
}

- (NSMutableArray *)allCitys
{
    if (_allCitys == nil)
    {
        self.allCitys = [NSMutableArray arrayWithArray:@[@"上海",@"北京",@"南京",@"南阳南阳",@"重庆",@"深圳",@"天津",@"郑州",@"信阳"]];
        
    }
    return _allCitys;
}

- (NSMutableArray *)imageArr
{
    if (_imageArr == nil)
    {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}


#pragma mark --- UITableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
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
    if (section == 0)
    {
        return 40;
    }
    else
    {
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row ==0 || indexPath.row == 1) {
            
            return 44;
        }
        else
        {
            return 110;
        }
    }
    else
    {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"时间";
            cell.textLabel.textColor = [UIColor blackColor];
            _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-70, 30)];
            _textField1.placeholder = @"请输入走失时间";
            _textField1.enabled = NO;
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, SCREEN_WIDTH-70, 1)];
            line.backgroundColor = kHCBackgroundColor;
            _textField1.text = self.timeStr;
            [cell addSubview:_textField1];
            [cell addSubview:line];
        }
        else  if (indexPath.row==1)
        {
            cell.textLabel.text = @"地点";
            cell.textLabel.textColor = [UIColor blackColor];
            
            _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-100, 30)];
            _textField2.placeholder = @"请输入走失地点";
            _textField2.enabled = NO;
            
            UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            locationButton.frame = CGRectMake(MaxX(_textField2), 12, 16, 20);
            locationButton.backgroundColor = [UIColor whiteColor];
            [locationButton setBackgroundImage:IMG(@"lossInfo_location") forState:UIControlStateNormal];
            [locationButton addTarget:self action:@selector(locationCity) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, SCREEN_WIDTH-70, 1)];
            line.backgroundColor = kHCBackgroundColor;
            
            [cell addSubview:_textField2];
            [cell addSubview:locationButton];
            [cell addSubview:line];
        }else  if(indexPath.row == 2)
        {
            cell.textLabel.text = @"描述";
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-100, 100)];
            _textView.delegate = self;
            
            _textView.font = [UIFont systemFontOfSize:15];
            _textView.text = self.DscStr    ;
            _label = [[UILabel alloc]initWithFrame:CGRectMake(0,5, 300, 30)];
            _label.text = @"请描述走失时候的相关情况";
            _label.textColor = COLOR(201, 201, 206, 1);
            [_textView addSubview:_label];
            
            
            if (self.DscStr) {
                _label.hidden = YES;
            }
            
            
            [cell addSubview:_textView];
            
        }
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 10, 60, 60);
        [button setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(choseMissPhotos) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(button)+5, 70, 10)];
        titleLabel.text = @"添加正面照片";
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textColor = [UIColor lightGrayColor];
        
        [cell addSubview:titleLabel];
        [cell addSubview:button];
        if (self.imageArr.count>0)
        {
            for (int i = 0; i < self.imageArr.count; i++)
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MaxX(titleLabel)+10+90*i, 10, 80, 80)];
                imageView.image = self.imageArr[i];
                imageView.tag = 300 + i;
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDelectPhoto:)];
                [imageView addGestureRecognizer:longPress];
                imageView.userInteractionEnabled = YES;
                [cell addSubview:imageView];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        label.textColor = [UIColor blackColor];
        label.text = @"  走失信息";
        return label;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (_isShowCity)
        {
            [self.cityView removeFromSuperview];
            _isShowCity = NO;
        }
        [self.view endEditing:NO];
        [self.datePicker show];
        _isShowDate = YES;
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self showCityPickerView];
    }
}

#pragma mark --- UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label.hidden = YES;
    [self.datePicker remove];
    [self cancelButtonAction];
    _isShowCity = NO;
    _isShowDate = NO;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text) {
        self.label.hidden = YES;
    }else
    {
        self.label.hidden = NO;
    }
    
    self.DscStr = textView.text;
}

#pragma mark --- UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.textField1) {
        self.timeStr = self.textField1.text;
    }
    else
    {
        self.AdressStr = self.textField2.text;
    }
}

#pragma mark --- HCPickerViewDelegate
//日期选择器
-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    self.textField1.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd HH:mm"];
    _isShowDate = NO;
}


#pragma mark - UIPickerViewDelegate

//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每列的的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.allCitys.count;
}

//每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH;
}

//每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.cityPickerView.frame.size.height/4;
}

//返回每行的标题
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.allCitys[row];
}

#pragma mark ---- UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            [[picker navigationBar] setTintColor:[UIColor whiteColor]];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            ZLPhotoPickerViewController *zlpVC = [[ZLPhotoPickerViewController alloc]init];
            zlpVC.maxCount = 3-self.imageArr.count;
            zlpVC.callBack = ^(NSArray *arr)
            {
                for (ZLPhotoAssets *zl in arr)
                {
                    UIImage *image = zl.originImage;
                    [self.imageArr addObject:image];
                }
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
                [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            };
            [self presentViewController:zlpVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageArr addObject:image];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark --- buttonClick

// 展示相册
//-(void)showAlbum
//{
//    [self.datePicker remove];
//    [self.view endEditing:YES];
//    [HCAvatarMgr manager].noUploadImage = YES;
//    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
//        if (result)
//        {
//            self.image = image;
//            self.bigView.image = image;
//        }
//    }];
//}

- (void)removeDatePicker
{
    _isShowDate = NO;
}

//弹出城市列表
- (void)showCityPickerView
{
    if (_isShowDate)
    {
        [self.datePicker remove];
        _isShowDate = NO;
    }
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cityView];
    _isShowCity = YES;
}

//定位
- (void)locationCity
{
    [self initMap];
}

//toolBar上的取消按钮
- (void)cancelButtonAction
{
    _isShowCity = NO;
    [self.cityView removeFromSuperview];
}

//toolBar上的确认按钮
- (void)sureButtonAction
{
    _isShowCity = NO;
    self.cityString = [self.allCitys objectAtIndex:[self.cityPickerView selectedRowInComponent:0]];
    [_cityButton setTitle:self.cityString forState:UIControlStateNormal];
    [self.cityView removeFromSuperview];
}


//选择相片
-(void)choseMissPhotos
{
    if (self.imageArr.count < 3)
    {
        UIActionSheet  *sheet = [[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [sheet  showInView:self.view];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"只能添加三张照片" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
        [alertView show];
    }
    
}

//长按相片删除
- (void)longPressDelectPhoto:(UILongPressGestureRecognizer *)sender
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH(sender.view)-20,0, 20, 20);
    button.backgroundColor = [UIColor  redColor];
    [button addTarget:self action:@selector(delectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sender.view addSubview:button];
}

//删除
- (void)delectBtnClick:(UIButton *)sender
{
    [self.imageArr removeObjectAtIndex:sender.superview.tag-300];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - Location

//初始化地图
-(void)initMap
{
    [MAMapServices sharedServices].apiKey =@"20e897d0e7d653770541a040a12065d8";
    _mapview = [[MAMapView alloc]init];
    _mapview.userTrackingMode = 1;
    _mapview.delegate = self;
    _mapview.showsUserLocation = YES;
}

//定位
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    [self encoded:userLocation];
}

//反地理编码
- (void)encoded:(MAUserLocation *)sender
{
    CLLocation *location = [[CLLocation alloc]initWithLatitude:sender.location.coordinate.latitude longitude:sender.location.coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSDictionary *dict = placemark.addressDictionary;
            
            NSString *streetStr = [dict objectForKey:@"Street"];
            NSString *countyStr = [dict objectForKey:@"SubLocality"];
            self.streetString = [countyStr stringByAppendingString:streetStr];
            NSLog(@"street address: %@",[dict objectForKey:@"Street"]);
            
            //获取城市
            self.cityString = placemark.locality;
            if (!self.cityString) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.cityString = placemark.administrativeArea;
            }
            NSLog(@"city = %@", self.cityString);
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        
        [self.cityButton setTitle:[self.cityString substringToIndex:[self.cityString length]-1]  forState:UIControlStateNormal];
        _textField2.text = self.streetString;
        self.nowLocation = sender.location;
        _mapview.showsUserLocation = NO;
        
    }];
}


#pragma mark ---- network

//提交
- (void)sendRequestData
{
    HCRadarTwinkleViewController *radarVC = [[HCRadarTwinkleViewController alloc] init];
    [self.navigationController pushViewController:radarVC animated:YES];
}

/*
-(void)sendRequestData
{
    
    if (IsEmpty(self.image)) {
        
        [self showHUDText:@"请点击上传走失时的图片"];
        return;
    }
    if (IsEmpty(self.textField1.text)) {
        
        [self showHUDText:@"请输入走失时间"];
        return;
    }
    if (IsEmpty([self.cityString stringByAppendingString:self.streetString])) {
        
        [self showHUDText:@"请输入走失地点"];
        return;
    }
    if (IsEmpty(self.textView.text)) {
        [self showHUDText:@"请输入走失描述"];
        return;
    }
    
    
    [self showHUDView:nil];
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkLoss,uuid,token]];
    
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.imgStr = responseObject[@"Data"][@"files"][0];
        [self requestData];
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)requestData
{
    HCPromisedSendApi *api = [[HCPromisedSendApi alloc]init];
    api.lossTime = self.textField1.text;

    api.callLocation = [NSString stringWithFormat:@"%f,%f",self.nowLocation.coordinate.latitude,self.nowLocation.coordinate.longitude];
    api.lossAddress = [self.cityString stringByAppendingString:self.streetString];
    api.lossDesciption = self.textView.text;
    api.tagArr = self.tagArr;
    api.ContractArr = self.contactArr;
        
    api.info = self.info;
    api.lossImageName = self.imgStr;
    [api startRequest:^(HCRequestStatus request, NSString *message, id respone)
    {
        if (request == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            UIViewController *vc= self.navigationController.viewControllers[0];
            [self.navigationController popToViewController:vc animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
                
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"showRadar"];// 发呼成功显示雷达效果
                
                NSLog(@"发呼应成功");
        }
        else
        {
            NSString *str = respone[@"message"];
            [self showHUDText:str];
        }
    }];
    
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
