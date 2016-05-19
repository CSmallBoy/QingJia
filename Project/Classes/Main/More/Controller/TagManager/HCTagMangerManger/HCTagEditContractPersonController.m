//
//  HCTagEditContractPersonController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//----------------------编辑或新增紧急联系人界面------------------------------------

#import "HCTagEditContractPersonController.h"
#import "HCAddContactPersonApi.h"
#import "HCTagContactInfo.h"
#import "HCChangeContactPersonApi.h"
#import "HCAvatarMgr.h"

#import "Utils.h"

#import <AddressBookUI/AddressBookUI.h>

@interface HCTagEditContractPersonController ()<ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UITextField *textField3;
@property (nonatomic,strong) NSString *imgStr;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong)UIButton *headBtn;

@property (nonatomic, strong)UIImageView *backgroundImage;//背景图片

//系统通讯录
@property (nonatomic, strong)ABPeoplePickerNavigationController *pickerVC;

@end

@implementation HCTagEditContractPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_info) {
        self.title = @"编辑紧急联系人";
    }else
    {
        self.title = @"新增紧急联系人";
    }
    [self setupBackItem];
    [self addAllSubviews];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

#pragma mark - lazyLoading

- (UIImageView *)backgroundImage
{
    if (_backgroundImage == nil)
    {
        self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        self.backgroundImage.image = IMG(@"addContactPerson");
        self.backgroundImage.userInteractionEnabled = YES;
    }
    return _backgroundImage;
}

- (UIButton *)headBtn
{
    if (_headBtn == nil)
    {
        self.headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake((375-140)/2/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT, 140/375.0*SCREEN_WIDTH, 140/375.0*SCREEN_WIDTH);
        _headBtn.layer.cornerRadius = 70/375.0*SCREEN_WIDTH;
        _headBtn.layer.masksToBounds = YES;
        if (self.image) {
            [_headBtn setBackgroundImage:self.image forState:UIControlStateNormal];
        }else
        {
            
            NSURL *url = [readUserInfo originUrl:self.info.imageName :@"contactor"];
            UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
            if (image) {
                [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
            else
            {
                [_headBtn setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
            }
        }
        [_headBtn addTarget:self action:@selector(showAlbum) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

#pragma mark - layoutView
- (void)addAllSubviews
{
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage addSubview:self.headBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(75/375.0*SCREEN_WIDTH, 330/668.0*SCREEN_HEIGHT, 40/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    titleLabel.text = @"姓名";
    titleLabel.textColor = [UIColor blackColor];

    _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMinY(titleLabel.frame), SCREEN_WIDTH-220/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    _textField1.text = _info.trueName;
    _textField1.textColor = [UIColor blackColor];
    
    UIButton *addressBook = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBook.frame = CGRectMake(CGRectGetMaxX(_textField1.frame), CGRectGetMinY(titleLabel.frame), 22/375.0*SCREEN_WIDTH, 22/668.0*SCREEN_HEIGHT);
    [addressBook setBackgroundImage:IMG(@"addContact_adressBook") forState:UIControlStateNormal];
    [addressBook addTarget:self action:@selector(pushToContacetPreson) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH-150/375.0*SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor grayColor];

    
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(lineView.frame) + 20/668.0*SCREEN_HEIGHT, 60/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    titleLabel1.text = @"手机号";
    titleLabel1.textColor = [UIColor blackColor];

    _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel1.frame), CGRectGetMinY(titleLabel1.frame), SCREEN_WIDTH-210/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    _textField2.text = _info.phoneNo;
    _textField2.textColor = [UIColor blackColor];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel1.frame), CGRectGetMaxY(titleLabel1.frame), SCREEN_WIDTH-150/375.0*SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    
    
    UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(lineView1.frame) + 20/668.0*SCREEN_HEIGHT,  40/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    titleLabel2.text = @"关系";
    titleLabel2.textColor = [UIColor blackColor];
    
    _textField3 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel2.frame), CGRectGetMinY(titleLabel2.frame), SCREEN_WIDTH-190/375.0*SCREEN_WIDTH, 25/668.0*SCREEN_HEIGHT)];
    _textField3.text = @"BB";
    _textField3.textColor = [UIColor blackColor];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel2.frame), CGRectGetMaxY(titleLabel2.frame), SCREEN_WIDTH-150/375.0*SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor grayColor];


    [self.backgroundImage addSubview:titleLabel];
    [self.backgroundImage addSubview:_textField1];
    [self.backgroundImage addSubview:addressBook];
    [self.backgroundImage addSubview:lineView];
    [self.backgroundImage addSubview:titleLabel1];
    [self.backgroundImage addSubview:_textField2];
    [self.backgroundImage addSubview:lineView1];
    [self.backgroundImage addSubview:titleLabel2];
    [self.backgroundImage addSubview:_textField3];
    [self.backgroundImage addSubview:lineView2];
    
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    //   ABRecordRef : 记录,一个联系人就是一条记录
    
    // 1.获取该联系人的姓名
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    /*
     桥接方式:
     (__bridge NSString *) : 仅仅是将对象的所有权交给Foundation的引用使用
     (__bridge_transfer NSString *) : 对象所有权交给Foundation的引用,并且内存也交给它来管理
     */
    NSString *firstname = (__bridge_transfer NSString *)firstName;
    NSString *lastname = (__bridge_transfer NSString *)lastName;
    NSLog(@"firstname:%@ lastname:%@", firstname, lastname);
    
    // 2.获取该联系人的电话号码
    // 2.1.获取该联系人的所有的电话
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    // 2.2.遍历所有的电话
    NSMutableArray *phoneNumArr = [NSMutableArray array];
    
    CFIndex count = ABMultiValueGetCount(phones);
    for (int i = 0; i < count; i++) {
        // 2.2.1.获取电话号码
        NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
        
        // 2.2.2.获取电话的标签
        NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
        
        [phoneNumArr addObject:phoneValue];
        NSLog(@"%@ %@", phoneLabel, phoneValue);
    }
    if (IsEmpty(firstname))
    {
        self.textField1.text = lastname;
    }
    else if (IsEmpty(lastname))
    {
        self.textField1.text = firstname;
    }
    else
    {
        self.textField1.text = [NSString stringWithFormat:@"%@%@",firstname, lastname];
    }
    
    if (phoneNumArr.count > 0)
    {
        //过滤手机号中的特殊字符
        NSString *phoneNum = [phoneNumArr objectAtIndex:0];
        NSCharacterSet *specialCharacters = [NSCharacterSet characterSetWithCharactersInString:@"@[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
        phoneNum = [[phoneNum componentsSeparatedByCharactersInSet:specialCharacters] componentsJoinedByString:@""];
        self.textField2.text = phoneNum;
    }
    // 3.释放不再使用的对象
    CFRelease(phones);
}


#pragma mark --- provate mothods

//跳转到通讯录页面
- (void)pushToContacetPreson
{
    self.pickerVC = [[ABPeoplePickerNavigationController alloc] init];
    self.pickerVC.peoplePickerDelegate = self;
    [self presentViewController:self.pickerVC animated:YES completion:nil];
}

-(void)itemClick:(UIBarButtonItem *)item
{
    if (_textField1.text.length == 0)
    {
        [self showHUDText:@"请输入联系人姓名"];
    }
    else if (_textField2.text.length == 0 || [Utils checkPhoneNum:_textField2.text] == NO)
    {
        [self showHUDText:@"手机号输入不正确"];
    }
    else
    {
        if (_info) {
            
            if (self.image) {
                [self upLoadImage];
            }else
            {
                [self chanageContactPerson];
            }
            
        }
        else
        {
            [self upLoadImage];
        }
    }
}

-(void)showAlbum
{
    [self.view endEditing:YES];
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            [self.headBtn setImage:self.image forState:UIControlStateNormal];
            
        }
    }];
    
    
}


#pragma mark --- netWork

-(void)requestData
{
    HCAddContactPersonApi *api = [[HCAddContactPersonApi alloc]init];
    
    api.trueName = self.textField1.text;
    api.phoneNo = self.textField2.text;
    api.imgStr = self.imgStr;
    
    [api startRequest:^(HCRequestStatus requesStatus, NSString *message, id respone) {
       
        if (requesStatus == HCRequestStatusSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            HCTagContactInfo *info = [[HCTagContactInfo alloc]init];
            info.trueName = self.textField1.text;
            info.phoneNo = self.textField2.text;
            info.imageName = self.imgStr;
            info.conactPersonImage = self.image;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewContractPerson" object:nil userInfo:@{@"info":info}];
        }
        else
        {
            [self showHUDText:@"保存失败"];
        }
        
    }];
   
}

-(void)upLoadImage
{
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",@"contactor",uuid,token]];
    if (self.image == nil)
    {
        self.image = IMG(@"Head-Portraits");
    }
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.imgStr = responseObject[@"Data"][@"files"][0];
        
        if (_info) {
        // 变更紧急联系人
            [self chanageContactPerson];
        }
        else
        {
        // 添加紧急联系人
            [self requestData];
        }
        
        
       
    } failure:^(NSError *error) {
        
    }];

 
}

-(void)chanageContactPerson
{

    HCChangeContactPersonApi *api = [[HCChangeContactPersonApi alloc]init];
    api.contactorId = self.info.contactorId;
    api.phoneNo = self.textField2.text;
    
    if (self.imgStr) {
        api.imageName = self.imgStr;
    }
    else
    {
        api.imageName = self.info.imageName;
    }

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
             [self showHUDText:@"保存失败"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
