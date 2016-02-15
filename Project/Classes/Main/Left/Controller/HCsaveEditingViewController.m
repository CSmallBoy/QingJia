//
//  HCsaveEditingViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCsaveEditingViewController.h"

@interface HCsaveEditingViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImagePickerController *_myPk;
    UIImageView *head_image;
}
@property (nonatomic,strong)NSArray *arr;
@end

@implementation HCsaveEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人事迹编辑";
    UIBarButtonItem *barButton= [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonClick)];
    self.navigationItem.rightBarButtonItem = barButton;
    [self setupBackItem];
    [self requestData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 40, 39)];
    label.text = _arr[indexPath.row];
    [cell addSubview:label];
    if (indexPath.row==0) {
        head_image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 2, 40, 40)];
        head_image.image = [UIImage imageNamed:@"image_hea.jpg"];
        [cell addSubview:head_image];
    }
    //显示输入框
    UITextField *text_f = [[UITextField alloc]initWithFrame:CGRectMake(55,3, SCREEN_WIDTH *0.85 - 55, 39)];
    text_f.placeholder = @"请您输入或选择相应的信息";
    [cell addSubview:text_f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //打开相册
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
    }else{
        
    }
}
//选择图片调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //编辑后的的图片 也可以是没有边际的图片
    UIImage *choose = [info objectForKey:UIImagePickerControllerEditedImage];
    head_image.image = choose;
    [_myPk dismissViewControllerAnimated:YES completion:nil];
 
}//点cancel
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_myPk dismissViewControllerAnimated:YES completion:nil];
}
-(void)barButtonClick{
    
}
//请求数据
- (void)requestData{
    _arr = @[@"头像",@"姓名",@"昵称",@"年龄",@"生日",@"住址"];
   //刷新tabview
    [self.tableView reloadData];
}

@end
