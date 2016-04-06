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
@interface HCEditUserMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    UIImagePickerController *_myPk;
    UIImageView *buttonImage;
    UIImage *choose;
    NSArray *Arr;
    NSArray *arr2;
    NHCUSerInfoApi *api;
    MyselfInfoModel *model;
    
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
    Arr = @[@[@"头像",@"昵称",@"姓名",@"性别",@"年龄",@"生日",@"属相",@"住址",@"公司",@"职业",@"健康"],
                  @[@"绑定手机号"]];
    arr2= @[@[@"请点击点击选择头像",@"请输入昵称",@"XXX",@"X",@"XX",@"XXXX-XX-XX",@"X",@"XXXXXXXXXXX",@"XXXXX",@"XXX",@"我的医疗急救卡"],
                           @[@"181109722222"]];
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
        return  11;
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell*)textField.superview];
    
    if (index.section==0) {
        switch (index.row) {
                
            case 1:
            {
                model.nickName = textField.text;
            }
                break;
            case 2:
            {
                model.tureName = textField.text;
            }
                break;
            case 3:
            {
                model.sex = textField.text;
            }
                break;
            case 4:
            {
                model.age = textField.text;
            }
                break;
            case 5:
            {
                model.birday = textField.text;
            }
                break;
            case 6:
            {
                model.Animalsign= textField.text;
                
            }
                break;
            case 7:
            {
                model.adress= textField.text;
                
            }
                break;
            case 8:
            {
                model.company= textField.text;
                
            }
                break;
            case 9:
            {
                model.professional = textField.text;
            }
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
    if (cell==nil) {
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
        text_tf.placeholder = arr2[indexPath.section][indexPath.row];
        text_tf.delegate =self;
        if (indexPath.row==0||indexPath.row==3||indexPath.row==6||indexPath.row==2) {
            text_tf.userInteractionEnabled = NO;
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
        
    }else if (indexPath.section==1 && indexPath.row==0){
        [self toChangeNumber];
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
    [self.tableView reloadData];
    api.myModel = model;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        
    }];
    //代理方法传值
    [_delegate userInfoName:model];
    
    NHCUploadImageApi *api_image = [[NHCUploadImageApi alloc]init];
    api_image.type = @"0";
    api_image.photoStr = model.PhotoStr;
    [api_image startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        
    }];
    
    
    
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[readUserInfo getReadDic]];
//    [dic addObserver:model.nickName forKeyPath:@"nickName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [dic addObserver:model.PhotoStr forKeyPath:@"PhotoStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [dic setObject:model.PhotoStr forKey:@"PhotoStr"];
    [readUserInfo Dicdelete];
    [readUserInfo creatDic:dic];
    [self showHUDText:@"保存成功"];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[HCUserMessageViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
