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

@interface HCPromisedMissMessageControll ()<UITextViewDelegate,HCPickerViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MAMapViewDelegate>

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
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeDatePicker) name:@"removeDatePicker" object:nil];
}


#pragma mark --- UITableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0 || indexPath.row == 1) {
        
        return 44;
    }
    else if (indexPath.row == 2)
    {
        return 84;
    }else
    {
        return 330;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"时间";
        cell.textLabel.textColor = [UIColor blackColor];
        _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(70, 7,SCREEN_WIDTH-70 , 30)];
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
        
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityButton.frame = CGRectMake(70, 7, 75, 30);
        _cityButton.backgroundColor = [UIColor whiteColor];
        [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityButton addTarget:self action:@selector(showCityPickerView) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *label = [UIButton buttonWithType:UIButtonTypeCustom];
        label.frame = CGRectMake(CGRectGetMaxX(_cityButton.frame), 7, 20, 30);
        label.backgroundColor = [UIColor whiteColor];
        label.userInteractionEnabled = NO;
        [label setTitle:@"市" forState:UIControlStateNormal];
        [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 7,SCREEN_WIDTH-CGRectGetMaxX(label.frame)-26, 30)];
        _textField2.text = self.AdressStr;
        
        UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        locationButton.frame = CGRectMake(CGRectGetMaxX(_textField2.frame), 12, 16, 20);
        locationButton.backgroundColor = [UIColor whiteColor];
        [locationButton setBackgroundImage:IMG(@"lossInfo_location") forState:UIControlStateNormal];
        [locationButton addTarget:self action:@selector(locationCity) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, SCREEN_WIDTH-70, 1)];
        line.backgroundColor = kHCBackgroundColor;
        
      
        
        [cell addSubview:label];
        [cell addSubview:_cityButton];
        [cell addSubview:_textField2];
        [cell addSubview:locationButton];
        [cell addSubview:line];
    }else  if(indexPath.row == 2)
    {
        cell.textLabel.text = @"描述";
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-100, 60)];
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
        
    }else
    {
        UIImageView *bigView = [[UIImageView alloc]initWithFrame:CGRectMake(70,5, SCREEN_WIDTH-100, 320)];
        ViewRadius(bigView, 5);
        bigView.layer.borderWidth = 1;
        bigView.layer.borderColor = [UIColor grayColor].CGColor;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((SCREEN_WIDTH-100)/2-30, 320/2-30, 60, 60);
        [button setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showAlbum) forControlEvents:UIControlEventTouchUpInside];
        
        [bigView addSubview:button];
        _bigView  = bigView;
        _bigView.userInteractionEnabled = YES;
        
        [cell addSubview:_bigView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 30)];
    label.textColor = [UIColor blackColor];
    
    label.text = @"走失信息";
    return label;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 40) ;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setBackgroundColor:kHCNavBarColor];
    [button addTarget:self action:@selector(sendRequestData) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ViewRadius(button, 5);

    [view addSubview:button];

    return view;
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

-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result
{
    NSDate *date = result[@"date"];
    self.textField1.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd HH:mm"];
    _isShowDate = NO;
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


#pragma mark --- setter Or getter 

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



#pragma mark --- private mothods

// 展示相册
-(void)showAlbum
{
    [self.datePicker remove];
    [self.view endEditing:YES];
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            self.bigView.image = image;
        }
    }];
}

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
