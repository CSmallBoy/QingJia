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
//省市县
#import "HCCityInfoMgr.h"
#import "HCCityInfo.h"
//定位
#import <AMapLocationKit/AMapLocationKit.h>
//设置推送tag
#import "HCSetTagMgr.h"

@interface HCPromisedMissMessageControll ()<UITextViewDelegate,HCPickerViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,AMapLocationManagerDelegate>

@property (nonatomic,strong) UITextField *textField1;
@property (nonatomic,strong) UITextField *textField2;
@property (nonatomic,strong) UITextView  *textView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *bigView ;
@property (nonatomic,strong) NSString *imgStr;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) HCPickerView *datePicker;

@property (nonatomic,strong) NSString *DscStr;


@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)UITextField *streetTextField;//街道
@property (nonatomic, strong)UIPickerView *cityPickerView;//城市选择器
@property (nonatomic, strong)UIToolbar *toolbar;//选择器的工具栏
@property (nonatomic, strong)UIView *cityView;
@property (nonatomic, strong)CLLocation *nowLocation;//当前经纬度

@property (nonatomic, assign)BOOL isShowCity;//弹出城市选择器
@property (nonatomic, assign)BOOL isShowDate;//弹出时间选择器

@property (nonatomic, strong)UIButton *commitButton;//提交按钮

@property (nonatomic, strong)NSMutableDictionary *citysInfo;//省市县三级数据源
@property (nonatomic, strong)NSDictionary *fristDic;//第一层字典
@property (nonatomic, strong)NSMutableArray *allProvince;//所有的省
@property (nonatomic, strong)NSMutableArray *allCitys;//某省所有的城市
@property (nonatomic, strong)NSMutableArray *allCountys;//某市所有的县

@property (nonatomic, copy)NSString *provinceStr;
@property (nonatomic, copy)NSString *cityStr;
@property (nonatomic, copy)NSString *countyStr;

@property (nonatomic,strong) AMapLocationManager *locationManager;//定位

@end

@implementation HCPromisedMissMessageControll

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"走失信息填写";
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
        _cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-180/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 180/668.0*SCREEN_HEIGHT)];
        _cityPickerView.backgroundColor = RGB(237, 237, 237);
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
        [_cityPickerView selectRow:0 inComponent:0 animated:NO];
    }
    return _cityPickerView;
}

- (UIToolbar *)toolbar
{
    if (_toolbar == nil)
    {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT)];
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
        _cityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _cityView.backgroundColor = [UIColor clearColor];
        [_cityView addSubview:self.toolbar];
        [_cityView addSubview:self.cityPickerView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf:)];
        [_cityView addGestureRecognizer:tap];
    }
    return _cityView;
}


- (NSMutableDictionary *)citysInfo
{
    if (_citysInfo == nil)
    {
        _citysInfo = [[HCCityInfoMgr manager] getAllProvinces];
    }
    return _citysInfo;
}

- (NSMutableArray *)allProvince
{
    if (_allProvince == nil)
    {
        _allProvince = [NSMutableArray arrayWithArray:[self.citysInfo allKeys]];
    }
    return _allProvince;
}

- (NSMutableArray *)allCitys
{
    if (_allCitys == nil)
    {
        _allCitys = [NSMutableArray array];
        self.fristDic = [self.citysInfo objectForKey:[self.allProvince objectAtIndex:0]];
        //取得某省所有的市
        for (NSString *string in [self.fristDic allKeys])
        {
            [_allCitys addObject:string];
        }
    }
    return _allCitys;
}

- (NSMutableArray *)allCountys
{
    if (_allCountys == nil)
    {
        _allCountys = [NSMutableArray array];
        NSMutableArray *array = [self.fristDic objectForKey:self.allCitys[0]];
        for (HCCityInfo *countyInfo in array)
        {
            [_allCountys addObject:countyInfo.regionName];
        }
    }
    return _allCountys;
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
        if (indexPath.row == 0 || indexPath.row == 1) {
            
            return 44;
        }
        else
        {
            return 100;
        }
    }
    else
    {
        return 310;
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
            locationButton.frame = CGRectMake(MaxX(_textField2), 10, 20, 25);
            locationButton.backgroundColor = [UIColor whiteColor];
            [locationButton setBackgroundImage:IMG(@"lossInfo_location") forState:UIControlStateNormal];
            [locationButton addTarget:self action:@selector(locationButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, SCREEN_WIDTH-70, 1)];
            line.backgroundColor = kHCBackgroundColor;
            
            [cell addSubview:_textField2];
            [cell addSubview:locationButton];
            [cell addSubview:line];
        }else  if(indexPath.row == 2)
        {
            cell.textLabel.text = @"描述";
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-100, 90)];
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
        self.bigView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 5, SCREEN_WIDTH-100, 300)];
        ViewRadius(self.bigView, 5);
        self.bigView.layer.borderWidth = 1;
        self.bigView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.bigView.userInteractionEnabled = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH(self.bigView)-60)/2, (HEIGHT(self.bigView)-60)/2, 60, 60);
        [button setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(choseMissPhotos) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(button)-5, MaxY(button)+5, 70, 10)];
        titleLabel.text = @"添加走失者正面照片";
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textColor = [UIColor lightGrayColor];
        
        [self.bigView addSubview:titleLabel];
        [self.bigView addSubview:button];
        [cell addSubview:self.bigView];
        
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
    return 3;
}

//每列的的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.allProvince.count;
    }
    else if (component == 1)
    {
        return self.allCitys.count;
    }
    else
    {
        return self.allCountys.count;
    }
}

//每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/3;
}

//每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.cityPickerView.frame.size.height/4;
}

//返回每行的标题
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.allProvince[row];
    }
    else if (component == 1)
    {
        return self.allCitys[row];
    }
    else
    {
        return self.allCountys[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        [self.allCitys removeAllObjects];
        [self.allCountys removeAllObjects];
        self.fristDic = [self.citysInfo objectForKey:[self.allProvince objectAtIndex:row]];
        //取得某省所有的市
        for (NSString *string in [self.fristDic allKeys])
        {
            [self.allCitys addObject:string];
        }
        [self.cityPickerView selectRow:0 inComponent:1 animated:YES];
        [self.cityPickerView reloadComponent:1];
        
        //取得某市下所有的县
        NSMutableArray *array = [self.fristDic objectForKey:self.allCitys[0]];
        for (HCCityInfo *countyInfo in array)
        {
            [self.allCountys addObject:countyInfo.regionName];
        }
        [self.cityPickerView selectRow:0 inComponent:2 animated:YES];
        [self.cityPickerView reloadComponent:2];
        
        self.provinceStr = self.allProvince[row];
        self.cityStr = self.allCitys[0];
        self.countyStr = self.allCountys[0];
    }
    else if (component == 1)
    {
        [self.allCountys removeAllObjects];
        NSMutableArray *array = [self.fristDic objectForKey:self.allCitys[row]];
        for (HCCityInfo *countyInfo in array)
        {
            [self.allCountys addObject:countyInfo.regionName];
        }
        [self.cityPickerView selectRow:0 inComponent:2 animated:YES];
        [self.cityPickerView reloadComponent:2];
        
        self.cityStr = self.allCitys[row];
        self.countyStr = self.allCountys[0];
    }
    else
    {
        self.countyStr = self.allCountys[row];
    }
}

//用来改变字体等
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = 1;
        pickerLabel.font = [UIFont systemFontOfSize:15];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark --- buttonClick

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
    [self.navigationController.view addSubview:self.cityView];
    _isShowCity = YES;
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
    if (IsEmpty(self.provinceStr))
    {
        self.provinceStr = self.allProvince[0];
        self.cityStr = self.allCitys[0];
        self.countyStr = self.allCountys[0];
    }
    self.textField2.text = [NSString stringWithFormat:@"%@%@%@", self.provinceStr, self.cityStr, self.countyStr];
    [self.cityView removeFromSuperview];
}

//手势移除城市选择器
- (void)removeSelf:(UITapGestureRecognizer *)sender
{
    [sender.view removeFromSuperview];
}


//选择相片
-(void)choseMissPhotos
{
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            self.bigView.image = image;
        }
    }];
    
}

#pragma mark - Location
- (void)locationButtonAction
{
    //先判断是否有定位权限
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务已关闭,请在设置\"隐私\"中开启定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
//        [AMapLocationServices sharedServices].apiKey = @"20e897d0e7d653770541a040a12065d8";
        self.locationManager = [[AMapLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    self.textField2.text = @"上海市闵行区集心路37号";
    self.cityStr = @"上海市";
    self.nowLocation = [[CLLocation alloc] initWithLatitude:31.232 longitude:37.2242];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!IsEmpty(placemarks))
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            self.textField2.text = placemark.name;
            self.nowLocation = location;
            self.cityStr = placemark.locality;
        }
    }];
    [self.locationManager stopUpdatingLocation];
}



#pragma mark ---- network

//提交
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
    if (IsEmpty(self.textField2.text)) {
        
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
    api.lossAddress = self.textField2.text;
    api.lossDesciption = self.textView.text;
    api.lossCityId = [self getCityFromPlist];
    api.tagArr = self.tagArr;
    api.ContractArr = self.contactArr;
        
    api.info = self.info;
    api.lossImageName = self.imgStr;
    [api startRequest:^(HCRequestStatus request, NSString *message, id respone)
    {
        if (request == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            //发送过呼之后的跳转
            UIViewController *vc= self.navigationController.viewControllers[0];
            [self.navigationController popToViewController:vc animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"callPromised" object:nil];// 发呼成功显示雷达效果
            NSLog(@"发呼应成功");
        }
        else
        {
            NSString *str = respone[@"message"];
            [self showHUDText:str];
        }
    }];
    
}


//取到对应城市的id
- (NSString *)getCityFromPlist
{
    NSMutableArray *allCitysArr = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path =[paths objectAtIndex:0];
    NSString *cityList =[path stringByAppendingPathComponent:@"city.plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:cityList];
    
    //取出所有的城市
    NSArray *allProvinceArr = dic[@"regionData"];
    for (NSDictionary *aDic in allProvinceArr)
    {
        NSString *fullName = aDic[@"regionName"];
        NSString *lastWord = [fullName substringFromIndex:[fullName length]-1];
        if ([lastWord isEqualToString:@"市"])
        {
            HCCityInfo *info = [HCCityInfo mj_objectWithKeyValues:aDic];
            [allCitysArr addObject:info];
        }
        else
        {
            NSArray *regions = aDic[@"regions"];
            for (NSDictionary *regionDic in regions)
            {
                HCCityInfo *info = [HCCityInfo mj_objectWithKeyValues:regionDic];
                [allCitysArr addObject:info];
            }
        }
    }
    for (HCCityInfo *info in allCitysArr)
    {
        if ([self.cityStr isEqualToString:info.regionName])
        {
            return info.regionId;
        }
    }
    return @"0";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
