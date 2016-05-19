//
//  HCBindTagController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCBindTagController.h"
#import "HCNewTagInfo.h"
#import "HCObjectListApi.h"
#import "HCTagActivateApi.h"
#import "HCAvatarMgr.h"

@interface HCBindTagController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * objectArr;
@property (nonatomic,strong) HCNewTagInfo *seletedInfo;
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *nomalLabel;

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *imgStr;


@property (nonatomic, strong)UIButton *colthingButton;//衣服图片
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *selectedColthingView;//选择衣服类型
@property (nonatomic, strong)UIView *remarksView;//备注
@property (nonatomic, strong)UITextField *descriptionTextField;//描述
@property (nonatomic, strong)UIImageView *frontPhoto;//正面照片

@end

@implementation HCBindTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定标签";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    [self.view addSubview:self.colthingButton];
    [self.view addSubview:self.label];
    [self.view addSubview:self.selectedColthingView];
    [self.view addSubview:self.remarksView];
    [self.view addSubview:self.frontPhoto];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonClick:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - lazyLoading;
- (UIButton *)colthingButton
{
    if (_colthingButton == nil)
    {
        _colthingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _colthingButton.frame = CGRectMake(110/375.0*SCREEN_WIDTH, 94/668.0*SCREEN_HEIGHT, 150/375.0*SCREEN_WIDTH, 150/668.0*SCREEN_HEIGHT);
        ViewRadius(_colthingButton, 5);
        _colthingButton.layer.borderWidth = 1;
        _colthingButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_colthingButton setBackgroundImage:IMG(@"clothingPhoto") forState:UIControlStateNormal];
        [_colthingButton addTarget:self action:@selector(changeColthingButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colthingButton;
}

- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(MinX(_colthingButton), CGRectGetMaxY(self.colthingButton.frame)+12/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-MinX(_colthingButton)*2, 20/668.0*SCREEN_HEIGHT)];
        _label.text = @"上传烫印衣物的照片";
        _label.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:14]];
        _label.textAlignment = 1;
    }
    return _label;
}

- (UIView *)selectedColthingView
{
    if (_selectedColthingView == nil)
    {
        _selectedColthingView = [[UIView alloc] initWithFrame:CGRectMake(70/375.0*SCREEN_WIDTH, CGRectGetMaxY(self.label.frame)+20/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-140/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        
        UIButton *selectedButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton1.frame = CGRectMake(0, 0, 20/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT);
        selectedButton1.selected = YES;
        [selectedButton1 setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        [selectedButton1 setBackgroundImage:IMG(@"buttonSelected") forState:UIControlStateSelected];
        [selectedButton1 addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(selectedButton1)+5/375.0*SCREEN_WIDTH, 0, (WIDTH(_selectedColthingView)-70/375.0*SCREEN_WIDTH)/3 - 25/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        label1.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:16]];
        label1.text = @"上装";
        
        UIButton *selectedButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton2.frame = CGRectMake(MaxX(label1)+35/375.0*SCREEN_WIDTH, 0, 20/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT);
        [selectedButton2 setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        [selectedButton2 setBackgroundImage:IMG(@"buttonSelected") forState:UIControlStateSelected];
        [selectedButton2 addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(selectedButton2)+5/375.0*SCREEN_WIDTH, 0, (WIDTH(_selectedColthingView)-70/375.0*SCREEN_WIDTH)/3 - 25/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        label2.text = @"下装";
        label2.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:16]];
        
        UIButton *selectedButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton3.frame = CGRectMake(MaxX(label2)+35/375.0*SCREEN_WIDTH, 0, 20/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT);
        [selectedButton3 setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        [selectedButton3 setBackgroundImage:IMG(@"buttonSelected") forState:UIControlStateSelected];
        [selectedButton3 addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(selectedButton3)+5/375.0*SCREEN_WIDTH, 0, (WIDTH(_selectedColthingView)-70/375.0*SCREEN_WIDTH)/3 - 25/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        label3.text = @"其他";
        label3.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:16]];
        
        [_selectedColthingView addSubview:selectedButton1];
        [_selectedColthingView addSubview:label1];
        [_selectedColthingView addSubview:selectedButton2];
        [_selectedColthingView addSubview:label2];
        [_selectedColthingView addSubview:selectedButton3];
        [_selectedColthingView addSubview:label3];
    }
    return _selectedColthingView;
}

- (UIView *)remarksView
{
    if (_remarksView == nil)
    {
        _remarksView = [[UIView alloc] initWithFrame:CGRectMake(45/375.0*SCREEN_WIDTH, MaxY(self.selectedColthingView)+25/668.0*SCREEN_HEIGHT, SCREEN_WIDTH-90/375.0*SCREEN_WIDTH, 21/668.0*SCREEN_HEIGHT)];
        
        UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        remarkLabel.text = @"备注:";
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21/668.0*SCREEN_HEIGHT, WIDTH(_remarksView), 1)];
        lineLabel.backgroundColor = [UIColor blackColor];
        
        self.descriptionTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(remarkLabel)+15/375.0*SCREEN_WIDTH, 0, WIDTH(_remarksView)-55/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        self.descriptionTextField.placeholder = @"请写下烫印衣物的颜色、款式、描述";
        self.descriptionTextField.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:15]];
        
        [_remarksView addSubview:lineLabel];
        [_remarksView addSubview:remarkLabel];
        [_remarksView addSubview:self.descriptionTextField];
    }
    return _remarksView;
}

-(UIImageView *)frontPhoto
{
    if (_frontPhoto == nil)
    {
        _frontPhoto = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200/375.0*SCREEN_WIDTH)/2, MaxY(self.remarksView)+35/668.0*SCREEN_HEIGHT, 200/375.0*SCREEN_WIDTH, 230/668.0*SCREEN_HEIGHT)];
        ViewRadius(_frontPhoto, 5);
        _frontPhoto.layer.borderWidth = 1;
        _frontPhoto.layer.borderColor = [UIColor grayColor].CGColor;
        _frontPhoto.userInteractionEnabled = YES;
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(75/375.0*SCREEN_WIDTH, 90/668.0*SCREEN_HEIGHT, 50/375.0*SCREEN_WIDTH, 50/375.0*SCREEN_WIDTH);
        [addButton setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(45/375.0*SCREEN_WIDTH, MaxY(addButton)+5/668.0*SCREEN_HEIGHT, WIDTH(_frontPhoto)-90/375.0*SCREEN_WIDTH, 10/668.0*SCREEN_HEIGHT)];
        explainLabel.text = @"添加绑定者的正面照片";
        explainLabel.textColor = RGB(130, 130, 130);
        explainLabel.font = [UIFont systemFontOfSize:[readUserInfo GetFontSizeByScreenWithPrt:12]];
        explainLabel.textAlignment = 1;
        
        [_frontPhoto addSubview:addButton];
        [_frontPhoto addSubview:explainLabel];
    }
    return _frontPhoto;
}

#pragma mark - buttonClickAction
//从相册选择衣服图片
- (void)changeColthingButtonImage:(UIButton *)sender
{
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            [sender setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
}

//从相册选择绑定者正面照
- (void)addButtonAction:(UIButton *)sender
{
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.frontPhoto.image = image;
            for (UIView *view in sender.superview.subviews)
            {
                view.hidden = YES;
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [sender.superview addGestureRecognizer:tap];
        }
    }];
}

//选择按钮
- (void)selectedButtonAction:(UIButton *)sender
{
    for (UIView *view in sender.superview.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton*)view;
            button.selected = NO;
        }
    }
    sender.selected = YES;
}

//轻点图片
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.frontPhoto.image = image;
        }
    }];
}


#pragma mark --- provite mothods
// 点击了确定按钮
-(void)sureButtonClick:(UIBarButtonItem *)right
{
    if (self.image == nil) {
    
        [self showHUDText:@"请上传标签图片"];
        return;
    }
    if (self.textField.text == nil) {
        [self showHUDText:@"请输入标签名字"];
        return;
    }
    
    if (self.seletedInfo ==nil) {
        [self showHUDText:@"创建对象以后才可以绑定标签"];
    }
    
    [self upLoadImge];
}

-(void)tap:(UITapGestureRecognizer*)tap
{

    [HCAvatarMgr manager].noUploadImage = YES;
    [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
        if (result)
        {
            self.image = image;
            UIImageView*imageView = (UIImageView*)tap.view;
            imageView.image = image;
        }
    }];
    
}

#pragma mark ---- setter Or getter

- (NSMutableArray *)objectArr
{
    if(!_objectArr){
        _objectArr = [NSMutableArray array];
    }
    return _objectArr;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}


- (UILabel *)nomalLabel
{
    if(!_nomalLabel){
        _nomalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 20)];
        _nomalLabel.textColor = [UIColor blackColor];
        _nomalLabel.textAlignment = NSTextAlignmentCenter;
        _nomalLabel.text = @"选择绑定为标签使用者";
    }
    return _nomalLabel;
}


- (UITextField *)textField
{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-65, 190, 130, 30)];
        _textField.placeholder  = @"请输入标签名字";
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = kHCBackgroundColor.CGColor;
    }
    return _textField;
}


#pragma mark --- network

//上传图片
-(void)upLoadImge
{
    
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkLabel,uuid,token]];
    [KLHttpTool uploadImageWithUrl:str image:self.image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.imgStr = responseObject[@"Data"][@"files"][0];
        
        [self upLoadData];
        
    } failure:^(NSError *error) {
        
    }];

}

//上传数据
-(void)upLoadData
{
    HCTagActivateApi *api = [[HCTagActivateApi alloc]init];
    api.labelGuid = self.labelGuid;
    api.imageName = self.imgStr;
    api.labelTitle = self.descriptionTextField.text;
    api.objectId = self.seletedInfo.objectId;
    api.contactorId1 = self.seletedInfo.contactorId1;
    api.contactorId2 = self.seletedInfo.contactorId2;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self showHUDSuccess:@"激活成功"];
            UIViewController *vc = self.navigationController.viewControllers[1];
            
            [self.navigationController popToViewController:vc animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestData" object:nil];
        }
        else
        {
            [self showHUDError:@"激活失败"];
        }
    }];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
