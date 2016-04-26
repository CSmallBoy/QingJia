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

@interface HCPromisedMissMessageControll ()<UITextViewDelegate,HCPickerViewDelegate,UITextFieldDelegate>

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
@end

@implementation HCPromisedMissMessageControll

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"走失信息填写";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    return 100;
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
        _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(70, 7,300 , 30)];
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
        _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(70, 7,300 , 30)];
        _textField2.placeholder = @"请输入走失地点";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, SCREEN_WIDTH-70, 1)];
        line.backgroundColor = kHCBackgroundColor;
        _textField2.text = self.AdressStr;
        [cell addSubview:_textField2];
        [cell addSubview:line];
    }else  if(indexPath.row == 2)
    {
        cell.textLabel.text = @"描述";
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH-100, 60)];
        _textView.delegate = self;
    
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 50, SCREEN_WIDTH-40, 40) ;
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
        
        [self.view endEditing:NO];
        [self.datePicker show];
        
    }
}

#pragma mark --- UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label.hidden = YES;
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
    self.textField1.text = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    
    
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


#pragma mark --- setter Or getter 

- (HCPickerView *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                                  datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        _datePicker.datePicker.maximumDate = [NSDate date];
        _datePicker.delegate = self;
    }
    return _datePicker;
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
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder  geocodeAddressString:self.textField2.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        api.callLocation = [NSString stringWithFormat:@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
        
        api.lossAddress = self.textField2.text;
        api.lossDesciption = self.textView.text;
        api.tagArr = self.tagArr;
        api.ContractArr = self.contactArr;
        
        api.info = self.info;
        api.lossImageName = self.imgStr;
       [api startRequest:^(HCRequestStatus request, NSString *message, id respone)      {
            
            if (request == HCRequestStatusSuccess)
            {
                [self hideHUDView];
                UIViewController *vc= self.navigationController.viewControllers[0];
                [self.navigationController popToViewController:vc animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"showRadar"];// 发呼成功显示雷达效果
                
                NSLog(@"发呼应成功");
            }
            
        }];
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
