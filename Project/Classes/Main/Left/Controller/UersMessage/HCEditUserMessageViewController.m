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



@interface HCEditUserMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    UIImagePickerController *_myPk;
    UIImageView *buttonImage;
    UIImage *choose;
    NSArray *Arr;
    NSArray *arr2;
    NHCUSerInfoApi *api;
    MyselfInfoModel *model;
    UIDatePicker * datePicker;
    UIView *view_back;
    NSString *str;
    
}

@end

@implementation HCEditUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    Arr = @[@[@"头像",@"昵称",@"姓名",@"性别",@"年龄",@"生日",@"属相",@"住址",@"公司",@"职业"],
                  @[@"绑定手机号"]];
    NSDictionary *dic = [readUserInfo getReadDic];
    if (IsEmpty(dic[@"UserInf"][@"imageNames"])) {
        NSArray *arr = @[@"请点击点击选择头像",@"请输入昵称",_ture_name,_sex,@"XX",@"XXXX-XX-XX",_shuxiang,@"XXXXXXXXXXX",@"XXXXX",@"XXX"];
        arr2= @[arr,
                @[@"181109722222"]];
    }else{
       
    }
   

}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  10;
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
            case 1:
                model.nickName = textField.text;
                break;
            case 2:
                model.tureName = textField.text;
                break;
            case 3:
                model.sex = textField.text;
                break;
            case 4:
                model.age = textField.text;
                break;
            case 6:
                model.Animalsign= textField.text;
                break;
            case 7:
                model.adress= textField.text;
                break;
            case 8:
                model.company= textField.text;
                break;
            case 9:
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
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 2, 40, 40)];
            headImage.image = choose;
            [cell addSubview:headImage];
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 50, 20)];
        UITextField *text_tf = [[UITextField alloc]initWithFrame:CGRectMake(62, 10, SCREEN_WIDTH-100, 20)];
        NSDictionary *dict_catch = [readUserInfo getReadDic];
        //需要先看网络上有没有   在判断本地有没有
        if (IsEmpty(dict_catch[@"UserInf"][@"career"])) {
            switch (indexPath.row) {
                case 2:
                    text_tf.text = arr2[indexPath.section][indexPath.row];
                    break;
                case 3:
                    text_tf.text = arr2[indexPath.section][indexPath.row];
                    break;
                case 6:
                    text_tf.text = arr2[indexPath.section][indexPath.row];
                    break;
        
                default:
                    break;
            }
            text_tf.placeholder = arr2[indexPath.section][indexPath.row];
        }else{
            text_tf.text = arr2[indexPath.section][indexPath.row];
        }
        
        text_tf.delegate =self;
        if (indexPath.row==0||indexPath.row==3||indexPath.row==6||indexPath.row==2) {
            text_tf.userInteractionEnabled = NO;
        }
        if (indexPath.row == 5) {
            if (IsEmpty(str)) {
                
            }else{
                text_tf.text = str;
            }
            
        }
        label.text = Arr[indexPath.section][indexPath.row];
        [cell addSubview:label];
        [cell addSubview:text_tf];
        
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.section);
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
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [myalert addAction:xiangce];
        [myalert addAction:paizhao];
        [myalert addAction:cancel];
        [self presentViewController:myalert animated:YES completion:nil];
    }else if (indexPath.section == 0 &&indexPath.row==5){
        [self makeDatePicker];
    }else if (indexPath.section==1 && indexPath.row==0){
        [self toChangeNumber];
    }else{
       
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //编辑后的的图片 也可以是没有边际的图片
    choose = [info objectForKey:UIImagePickerControllerEditedImage];
    NSString *chooseImageStr = [readUserInfo imageString:choose];
    model.PhotoStr = chooseImageStr;
    [self.tableView reloadData];
    [_myPk dismissViewControllerAnimated:YES completion:nil];
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
    //先验证是否否输入
    if (IsEmpty(choose)||IsEmpty(model.nickName)||IsEmpty(model.age)||IsEmpty(model.birday)||IsEmpty(model.adress)||IsEmpty(model.company)||IsEmpty(model.professional)) {
        [self showHUDSuccess:@"您还有为填写的内容"];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[readUserInfo getReadDic]];
        //先上传图片 在完善用户信息
        NSString * string = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",@"user",[HCAccountMgr manager].loginInfo.UUID,[readUserInfo getReadDic][@"Token"]]];
        //chosse 是选择好的图片
        [KLHttpTool uploadImageWithUrl:string image:choose success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            //在这个地方执行上传文字的操作
            model.userPhoto = responseObject[@"Data"][@"files"][0];
            api.myModel = model;
            [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chineseZodiac) {
                if (requestStatus == HCRequestStatusSuccess) {
                    [dic setObject:str forKey:@"birthday"];
                    [dic setObject:chineseZodiac forKey:@"chineseZodiac"];
                    [dic setObject:model.userPhoto forKey:@"PhotoStr"];
                    [dic setObject:model.nickName forKey:@"nickName"];
                    [dic setObject:model.age forKey:@"age"];
                    [dic setObject:model.adress forKey:@"adress"];
                    [dic setObject:model.company forKey:@"company"];
                    [dic setObject:model.professional forKey:@"professional"];
                    [readUserInfo Dicdelete];
                    [readUserInfo creatDic:dic];
                    
                    
                    [self hideHUDView];
                    if (requestStatus == HCRequestStatusSuccess) {
                        
                        for (UIViewController *temp in self.navigationController.viewControllers) {
                            if ([temp isKindOfClass:[HCUserMessageViewController class]]) {
                                
                                [self.navigationController popToViewController:temp animated:YES];
                            }
                        }
                        
                        NSDictionary *dict = @{@"photo":choose};
                        
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
            
        }];
    }
    

//    //完善用户信息
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSString *chineseZodiac){
//        if (requestStatus == HCRequestStatusSuccess) {
//            
//         
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
    view_back = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.67, SCREEN_WIDTH, SCREEN_HEIGHT *0.33)];
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.03, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    //[datePicker addTarget:self action:@selector(makeDate:) forControlEvents:UIControlEventValueChanged];
    datePicker.backgroundColor = [UIColor grayColor];
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    view_back.backgroundColor = [UIColor grayColor];
    UIButton *sure_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure_button setTitle:@"确定" forState:UIControlStateNormal];
    [sure_button setFrame:CGRectMake(SCREEN_WIDTH *0.85, 0, SCREEN_WIDTH *0.15, SCREEN_HEIGHT *0.03)];
    [sure_button setBackgroundColor:[UIColor redColor]];
    [sure_button addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel_button setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_button setBackgroundColor:[UIColor redColor]];
    [cancel_button setFrame:CGRectMake(0, 0, SCREEN_WIDTH *0.15, SCREEN_HEIGHT *0.03)];
    [view_back addSubview:sure_button];
    [view_back addSubview:cancel_button];
    [view_back addSubview:datePicker];
    [self.view addSubview:view_back];
    
}
-(void)getDate:(UIDatePicker*)sender{
    NSDateFormatter *formatrer = [[NSDateFormatter alloc]init];
    //格式化输出
    [formatrer setDateFormat:@"yyyy-MM-dd"];
    str = [formatrer stringFromDate:datePicker.date];
    //[ setTitle:str forState:UIControlStateNormal];
    [view_back removeFromSuperview];
    NSIndexPath  *indexPath_1=[NSIndexPath indexPathForRow:5 inSection:0];
    model.birday = str;
    NSArray*indexArray=[NSArray  arrayWithObject:indexPath_1];
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
