//
//  HCEditUserMessageViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditUserMessageViewController.h"
#import "HCEditUserMessageTableViewCell.h"
#import "HCChangeBoundleTelNumberControll.h"
#import "HCUserMessageViewController.h"
#import "NHCUSerInfoApi.h"
#import "MyselfInfoModel.h"
#import "NHCUploadImageApi.h"
//医疗信息卡
#import "HCUserHeathViewController.h"


#import "HCPickerView.h"



@interface HCEditUserMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,HCPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UIImagePickerController *_myPk;
    UIImagePickerController * _picker;
    UIImageView *buttonImage;
    UIImage *choose;
    NSArray *Arr;
    NSArray *arr2;
    NHCUSerInfoApi *api;
    MyselfInfoModel *model;
    MyselfInfoModel *selfModel;
    UIDatePicker * datePicker;
    UIView *view_back;
    NSString *str;
    BOOL FromPhoto;
    
    //昵称
    UITextField *nickName_tf;
    //姓名
    UITextField *name_tf;
    //性别
    UITextField *sex_tf;
    //生日
    UILabel *birthDay_tf;
    //属相
    UITextField *animal_tf;
    //地址
    UITextField *address_tf;
    //祖籍
    UILabel *hometown_tf;
    //签名
    UITextField *sign_tf;
    //手机号
    UITextField *phone_tf;
    
    NSArray *provinces;
    
    UIToolbar  *_toolbar;
    
    UIPickerView *provincesPickview;
}
@property (nonatomic, strong) NSDictionary *person_dict;

@end

@implementation HCEditUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获得个人信息缓存
    _person_dict = [readUserInfo getReadDic];
    selfModel = [[MyselfInfoModel alloc]init];
    self.title = @"个人信息编辑";
    [self setupBackItem];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.scrollEnabled = NO;
    choose =  IMG(@"2Dbarcode_message_HeadPortraits");
    // 保存按钮
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem =right;
    model = [[MyselfInfoModel alloc]init];
    api = [[NHCUSerInfoApi alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toChangeNumber) name:@"toChangeNumber" object:nil];
    NSDictionary *dic = [readUserInfo getReadDic];
    Arr = @[@[@"头像",@"昵称",@"姓名",@"性别",@"生日",@"属相",@"住址",@"祖籍",@"签名"],
            @[@"绑定手机号"]];
    
    //第一步  先判断是否本地编辑过
    if(IsEmpty(dic[@"company"])){
        if (IsEmpty(dic[@"UserInf"][@"imageName"]))
        {
            //NSArray *arr = @[@"请点击点击选择头像",@"请输入昵称",_ture_name,_sex,_birthday,_shuxiang,@"请输入住址",@"请输点击选择祖籍",@"请输入签名"];
            //            arr2= @[arr,
            //                    @[@"181109722222"]];
        }else{
            //            NSArray *arr = @[@"请点击点击选择头像",@"请输入昵称",_ture_name,_sex,_birthday,_shuxiang,_adress,_copany,_professional];
            //            arr2= @[arr,
            //                    @[@"181109722222"]];
        }
    }else{
        if (IsEmpty(dic[@"UserInf"][@"imageName"]))
            //第二 判断以前手否编辑过
        {
            //为空的话数组之间的赋值要变的
            NSArray *arr = @[@"请点击点击选择头像",@"请输入昵称",_ture_name,_sex,_birthday,_shuxiang,@"请输入住址",@"请输入公司",@"请输入职位"];
            arr2= @[arr,
                    @[@"181109722222"]];
        }else{
            NSArray *arr = @[@"请点击点击选择头像",@"请输入昵称",_ture_name,_sex,_birthday,_shuxiang,_adress,_copany,_professional];
            arr2= @[arr,
                    @[@"181109722222"]];
        }
    }
    
    
    model.nickName = _ture_name;
    model.birday = _birthday;
    model.company = _copany;
    model.adress = _adress;
    model.professional = _professional;
    str = _birthday;
    
    if (_person_dict[@"nickName"]) {
        
        NSLog(@"%@",_person_dict);
        selfModel.nickName =  _person_dict[@"nickName"];
        selfModel.userPhoto = _person_dict[@"imageName"];
        selfModel.adress =  _person_dict[@"adress"];
        selfModel.company =  _person_dict[@"career"];
        selfModel.career = _person_dict[@"career"];
        selfModel.userDescription = _person_dict[@"userDescription"];
        selfModel.birday = _person_dict[@"birthDay"];
        selfModel.Animalsign = _person_dict[@"chineseZodiac"];
        
    }
    else
    {
        selfModel.nickName =  _person_dict[@"UserInf"][@"nickName"];
        selfModel.userPhoto = _person_dict[@"UserInf"][@"imageName"];
        selfModel.adress =  _person_dict[@"UserInf"][@"homeAddress"];
        selfModel.company =  _person_dict[@"UserInf"][@"career"];
        selfModel.career = _person_dict[@"UserInf"][@"company"];
        selfModel.userDescription = _person_dict[@"UserInf"][@"userDescription"];
        selfModel.birday = _person_dict[@"UserInf"][@"birthDay"];
        selfModel.Animalsign = _person_dict[@"UserInf"][@"chineseZodiac"];
    }
    
    
    
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  9;
    }else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }else
    {
        return 20;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
//修改触发的方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell*)textField.superview];
    if (index.section==0) {
        switch (index.row) {
                //昵称
            case 1:
                model.nickName = textField.text;
                break;
                //生日
            case 4:
                model.birday = textField.text;
                break;
                //住址
            case 6:
                model.adress= textField.text;
                break;
                //公司
            case 7:
                model.company= textField.text;
                break;
                //职业
            case 8:
                model.professional = textField.text;
                break;
            default:
                break;
        }
    }
    
}
-(UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    for (UIView *view1 in cell.subviews) {
        if ([view1 isKindOfClass:[UIView class]]) {
            [view1 removeFromSuperview];
        }
    }
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier
                ];
    }
    if(indexPath.section==1){
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
        label1.text = @"绑定手机号";
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 120, 44)];
        label2.text = _person_dict[@"UserInf"][@"phoneNo"];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 0, 50, 44)];
        label3.text = @"修改";
        [cell.contentView addSubview:label3];
        [cell.contentView addSubview:label2];
        [cell.contentView addSubview:label1];
        
    }
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 2, 40, 40)];
            if (IsEmpty(_headimage)) {
                //这个88 代表的是 宽度 和 高度 就是小差
                if (choose.size.width==88) {
                    
                }else{
                    headImage.image = choose;
                }
            }else{
                if (choose.size.width==88) {
                    [headImage sd_setImageWithURL:[readUserInfo url:selfModel.userPhoto :kkUser]];
                }else{
                    headImage.image = choose;
                }
            }
            [cell addSubview:headImage];
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 50, 20)];
        UITextField *text_tf = [[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
        NSDictionary *dict_catch = [readUserInfo getReadDic];
        //需要先看网络上有没有   在判断本地有没有
        
        
        if (indexPath.row == 1) {
            
            NSLog(@"%@",_person_dict);
            nickName_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            nickName_tf.returnKeyType = UIReturnKeyDone;
            nickName_tf.text = selfModel.nickName;
            nickName_tf.delegate = self;
            [cell.contentView addSubview:nickName_tf];
        }
        else if (indexPath.row == 2)
        {
            name_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            name_tf.text = _person_dict[@"UserInf"][@"trueName"];
            name_tf.enabled = NO;
            [cell.contentView addSubview:name_tf];
        }
        else if (indexPath.row == 3)
        {
            sex_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            sex_tf.text = _person_dict[@"UserInf"][@"sex"];
            sex_tf.enabled = NO;
            [cell.contentView addSubview:sex_tf];
        }
        else if (indexPath.row == 4)
        {
            birthDay_tf =[[UILabel alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            birthDay_tf.text = selfModel.birday;
            
            [cell.contentView addSubview:birthDay_tf];
        }
        else if (indexPath.row == 5)
        {
            animal_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            animal_tf.text = selfModel.Animalsign;
            animal_tf.enabled = NO;
            animal_tf.delegate = self;
            [cell.contentView addSubview:animal_tf];
        }
        else if (indexPath.row == 6)
        {
            address_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            address_tf.text = selfModel.adress;
            address_tf.returnKeyType = UIReturnKeyDone;
            address_tf.delegate = self;
            [cell.contentView addSubview:address_tf];
        }
        else if (indexPath.row == 7)
        {
            hometown_tf =[[UILabel alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            hometown_tf.text = selfModel.career;
            
            [cell.contentView addSubview:hometown_tf];
        }
        else if (indexPath.row == 8)
        {
            sign_tf =[[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
            sign_tf.text = selfModel.userDescription;
            sign_tf.returnKeyType = UIReturnKeyDone;
            sign_tf.delegate = self;
            [cell.contentView addSubview:sign_tf];
        }
        
        
        text_tf.delegate =self;
        if (indexPath.row==0||indexPath.row==3||indexPath.row==5||indexPath.row==2||indexPath.row==4) {
            text_tf.userInteractionEnabled = NO;
        }
        if (indexPath.row == 4) {
            if (IsEmpty(str)) {
                
            }else{
                text_tf.text = str;
            }
        }
        label.text = Arr[indexPath.section][indexPath.row];
        [cell addSubview:label];
        //        [cell addSubview:text_tf];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 &&indexPath.row ==0) {
        UIAlertController *myalert =[UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *xiangce = [UIAlertAction actionWithTitle:@"从相册里选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _myPk = [[UIImagePickerController alloc]init];
            _myPk.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //是否允许编辑图片
            _myPk.allowsEditing = YES;
            _myPk.delegate = self;
            [self presentViewController:_myPk animated:YES completion:nil];
        }];
        UIAlertAction *paizhao = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开相机
            _picker = [[UIImagePickerController alloc]init];
            _picker.delegate = self;
            _picker.allowsEditing = YES;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_picker animated:YES completion:nil];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [myalert addAction:xiangce];
        [myalert addAction:paizhao];
        [myalert addAction:cancel];
        [self presentViewController:myalert animated:YES completion:nil];
    }else if (indexPath.section == 0 &&indexPath.row==4){
        
        [self makeDatePicker];
        
    }else if (indexPath.section==1 && indexPath.row==0){
        [self toChangeNumber];
    }
    else if (indexPath.section == 0 && indexPath.row ==7)
    {
        //文件路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path =[paths objectAtIndex:0];
        NSString *cityList =[path stringByAppendingPathComponent:@"city.plist"];
        
        NSDictionary *Dic = [NSDictionary dictionaryWithContentsOfFile:cityList];
        provinces = [Dic objectForKey:@"regionData"];
        
        NSLog(@"%@",provinces);
        
        [self makeProvincesPicker];
    }
    else if (indexPath.section == 0 && indexPath.row == 2)
    {
        [self showHint:@"sorry,姓名不可以更改"];
    }
    else if (indexPath.section ==0 && indexPath.row ==3)
    {
        [self showHint:@"sorry,性别不可以更改"];
    }
    else if (indexPath.section == 0 && indexPath.row ==5)
    {
        [self showHint:@"sorry,属相不可以更改"];
    }
    else if (indexPath.section ==0 && indexPath.row == 8)
    {
        selfModel.userDescription = sign_tf.text;
    }
    else{
        
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    FromPhoto = YES;
    if (picker==_myPk)
    {
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_myPk dismissViewControllerAnimated:YES completion:nil];
    }else{
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_picker dismissViewControllerAnimated:YES completion:nil];
    }
    [self.tableView reloadData];
    
}
#pragma mark ---- private mothods
// 跳转绑定手机页面
-(void)toChangeNumber
{
    HCChangeBoundleTelNumberControll *changeVC = [[HCChangeBoundleTelNumberControll alloc]init];
    
    [self.navigationController pushViewController:changeVC animated:YES];
    
}

-(void)saveClick:(UIBarButtonItem *)item
{
    model.tureName = _ture_name;
    model.sex = _sex;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[readUserInfo getReadDic]];
    //先上传图片 在完善用户信息
    NSString * string = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",@"user",[HCAccountMgr manager].loginInfo.UUID,[readUserInfo getReadDic][@"Token"]]];
    //chosse 是选择好的图片
    [KLHttpTool uploadImageWithUrl:string image:choose success:^(id responseObject)
     {
         //在这个地方执行上传文字的操作
         if (FromPhoto) {
             selfModel.userPhoto = responseObject[@"Data"][@"files"][0];
         }else{
             model.userPhoto = _headimage;
         }
         selfModel.userDescription = sign_tf.text;
         selfModel.nickName = nickName_tf.text;
         selfModel.adress = address_tf.text;
         selfModel.career =animal_tf.text;
         selfModel.birday = birthDay_tf.text;
         
         api.myModel = selfModel;
         
         [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chineseZodiac)
          {
              
              if (requestStatus == HCRequestStatusSuccess)
              {
                  if (IsEmpty(str)) {
                      
                  }else{
                      [dic setObject:str forKey:@"birthday"];
                  }
                  
                  [dic setObject:chineseZodiac forKey:@"chineseZodiac"];
                  [dic setObject:selfModel.userPhoto forKey:@"imageName"];
                  [dic setObject:selfModel.nickName forKey:@"nickName"];
                  [dic setObject:selfModel.adress forKey:@"adress"];
                  [dic setObject:selfModel.company forKey:@"career"];
                  [dic setObject:selfModel.professional forKey:@"professional"];
                  [dic setObject:selfModel.userDescription forKey:@"userDescription"];
                  [dic setObject:selfModel.birday forKey:@"birthDay"];
                  [readUserInfo Dicdelete];
                  [readUserInfo creatDic:dic];
                  //[[NSNotificationCenter defaultCenter] postNotificationName:@"Photo" object:nil userInfo:dic];
                  [self hideHUDView];
                  if (requestStatus == HCRequestStatusSuccess)
                  {
                      for (UIViewController *temp in self.navigationController.viewControllers)
                      {
                          if ([temp isKindOfClass:[HCUserMessageViewController class]])
                          {
                              [self.navigationController popToViewController:temp animated:YES];
                          }
                      }
                      //通知左边修改头像
                      NSDictionary *dict = @{@"photo":selfModel.userPhoto};
                      [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserPhoto" object:nil userInfo:dict];
                      
                      [self showHUDSuccess:@"保存成功"];
                  }
                  else
                  {
                      [self showHUDSuccess:@"保存失败"];
                  }
              }
          }];
     } failure:^(NSError *error) {
         [self showHUDSuccess:@"服务器异常"];
     }];
    
    
    
    //    //完善用户信息
    //    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chineseZodiac){
    //        if (requestStatus == HCRequestStatusSuccess) {
    //            [dic setObject:str forKey:@"birthday"];
    //            [dic setObject:chineseZodiac forKey:@"chineseZodiac"];
    //            [dic setObject:model.PhotoStr forKey:@"PhotoStr"];
    //            [dic setObject:model.nickName forKey:@"nickName"];
    //            [dic setObject:model.age forKey:@"age"];
    //            [dic setObject:model.adress forKey:@"adress"];
    //            [dic setObject:model.company forKey:@"company"];
    //            [dic setObject:model.professional forKey:@"professional"];
    //
    //            [readUserInfo Dicdelete];
    //            [readUserInfo creatDic:dic];
    //        }
    //
    //    }];
    //    //代理方法传值
    //    [_delegate userInfoName:model];
    //    //图片上传
    //    NHCUploadImageApi *api_image = [[NHCUploadImageApi alloc]init];
    //    api_image.type = @"0";
    //    api_image.photoStr = model.PhotoStr;
    //    [api_image startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
    //
    //        [self hideHUDView];
    //        if (requestStatus == HCRequestStatusSuccess) {
    //
    //            for (UIViewController *temp in self.navigationController.viewControllers) {
    //                if ([temp isKindOfClass:[HCUserMessageViewController class]]) {
    //
    //                    [self.navigationController popToViewController:temp animated:YES];
    //                }
    //            }
    //
    //            NSDictionary *dict = @{@"photo":choose};
    //
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserPhoto" object:nil userInfo:dict];
    //            [self showHUDSuccess:@"保存成功"];
    //        }
    //        else
    //        {
    //            [self showHUDSuccess:@"保存失败"];
    //        }
    //
    //    }];
    
}
//时间选择器
-(void)makeDatePicker{
    //    view_back = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.67, SCREEN_WIDTH, SCREEN_HEIGHT *0.33)];
    //    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.03, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    //    datePicker.datePickerMode = UIDatePickerModeDate;
    //    //[datePicker addTarget:self action:@selector(makeDate:) forControlEvents:UIControlEventValueChanged];
    //    datePicker.backgroundColor = [UIColor grayColor];
    //    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    //    view_back.backgroundColor = [UIColor grayColor];
    //    UIButton *sure_button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sure_button setTitle:@"确定" forState:UIControlStateNormal];
    //    [sure_button setFrame:CGRectMake(SCREEN_WIDTH *0.85, 0, SCREEN_WIDTH *0.15, SCREEN_HEIGHT *0.03)];
    //    [sure_button setBackgroundColor:[UIColor redColor]];
    //    [sure_button addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    //    UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [cancel_button setTitle:@"取消" forState:UIControlStateNormal];
    //    [cancel_button setBackgroundColor:[UIColor redColor]];
    //    [cancel_button setFrame:CGRectMake(0, 0, SCREEN_WIDTH *0.15, SCREEN_HEIGHT *0.03)];
    //    [view_back addSubview:sure_button];
    //    [view_back addSubview:cancel_button];
    //    [view_back addSubview:datePicker];
    //    [self.view addSubview:view_back];
    //
    
    
    
    HCPickerView *pick;
    pick = [[HCPickerView alloc] initDatePickWithDate:[NSDate date]
                                       datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
    pick.datePicker.maximumDate = [NSDate date];
    pick.delegate = self;
    [self.view addSubview:pick];
    
}

-(void)makeProvincesPicker
{
    provincesPickview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
    provincesPickview.showsSelectionIndicator = YES;
    [provincesPickview setBackgroundColor:[UIColor lightGrayColor]];
    provincesPickview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    provincesPickview.delegate = self;
    [self.view addSubview:provincesPickview];
    [provincesPickview selectRow:1 inComponent:0 animated:YES];
    
    _toolbar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self.view addSubview:_toolbar];
}

-(UIToolbar *)setToolbarStyle {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"    取消" style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
    [lefttem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定    " style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    toolbar.items = @[lefttem,centerSpace,right];
    
    return toolbar;
}

-(void)setToolbarWithPickViewFrame{
    
    _toolbar.frame = CGRectMake(0, MinY(provincesPickview) - 44,[UIScreen mainScreen].bounds.size.width, 44);
    
}
-(void)remove
{
    [_toolbar removeFromSuperview];
    [provincesPickview removeFromSuperview];
}

-(void)doneClick
{
    NSLog(@"%ld",(long)[provincesPickview selectedRowInComponent:0]);
    NSLog(@"--------%@",[provinces[[provincesPickview selectedRowInComponent:0]] objectForKey:@"regionName"]);
    [_toolbar removeFromSuperview];
    [provincesPickview removeFromSuperview];
    hometown_tf.text =[provinces[[provincesPickview selectedRowInComponent:0]] objectForKey:@"regionName"];
    selfModel.company = hometown_tf.text;
    
}
#pragma mark ---------pickerviewdeledate-------
//-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
//
//{
//    return;
//}

//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

//返回数组总数
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return provinces.count;//将数据建立一个数组
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [provinces[row] objectForKey:@"regionName"];
    
}
//触发事件
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"12312");
}

-(void)doneBtnClick:(HCPickerView *)pickView result:(NSDictionary *)result{
    
    NSDate *date = result[@"date"];
    //model.birday = [Utils getDateStringWithDate:date format:@"yyyy-MM-dd"];
    //    str = model.birday;
    //    NSIndexPath  *indexPath_1=[NSIndexPath indexPathForRow:4 inSection:0];
    //    NSArray*indexArray=[NSArray  arrayWithObject:indexPath_1];
    //    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:(UITableViewRowAnimationAutomatic)];
    birthDay_tf.text = [NSString stringWithFormat:@"%@",[Utils getDateStringWithDate:date format:@"yyyy-MM-dd"]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
