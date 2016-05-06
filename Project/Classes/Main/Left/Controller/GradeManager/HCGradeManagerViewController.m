//
//  HCGradeManagerViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeManagerViewController.h"
#import "HCCodeLookViewController.h"
#import "HCCheckViewController.h"
#import "HCGradeManagerTableViewCell.h"
#import "HCFriendMessageInfo.h"
#import "HCAddFriendViewController.h"
#import "UIImageView+WebCache.h"
#import "HCFriendMessageApi.h"
#import "HCCreateGradeInfo.h"
#import "sigleFamilyMessage.h"
//个人 家庭 头像
#import "HCHomeUserPhotoViewController.h"
//修改家庭的api
#import "NHCEditingFamilyApi.h"


static NSString * const reuseIdentifier = @"FriendCell";

@interface HCGradeManagerViewController ()<HCGradeManagerTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    BOOL isTure;
    BOOL isEditing;
    UIImagePickerController *_myPK;
    UIImagePickerController *_picker;
    UIImage *choose;
}

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic,strong) HCCreateGradeInfo *info;
@property (nonatomic, strong) UIBarButtonItem *bar;

@end

@implementation HCGradeManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"家庭名字";
    [self setupBackItem];
    self.tableView.tableHeaderView = self.headImageView;
    self.bar = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(ChangeBool)];
    self.navigationItem.rightBarButtonItem = self.bar;
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    //长按手势
    UILongPressGestureRecognizer *long_press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:long_press];
    [self.headImageView addGestureRecognizer:tap];
}
- (void)ChangeBool{
    isTure = !isTure;
    if (isTure) {
        self.bar.title = @"保存";
    }else{
        self.bar.title = @"编辑";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self requestGradeManager];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCGradeManagerTableViewCell *cell = [[HCGradeManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.array = self.dataSource;
    
    if (isTure) {
        cell.IsAble = YES;
    }else{
        cell.IsAble = NO;
    }
    if (isEditing) {
        cell.image = choose;
        cell.IsEditingPhoto = YES;
    }else{
        
    }
    cell.info = _info;
    cell.indexPath = indexPath;
    cell.textField.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCViewController *vc = nil;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        vc = [[HCCodeLookViewController alloc] init];
        NSURL *url = [readUserInfo originUrl:self.info.imageName :kkFamail];
        
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        if (image == nil) {
            
            image = IMG(@"head.jpg");
        }
        
        vc.data = @{@"info":self.info,@"image":image};
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        vc = [[HCCheckViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section) ? 2 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section && indexPath.row)
    {
        NSInteger row = self.dataSource.count/4;
        if (self.dataSource.count%4)
        {
            row++;
        }
        return row*(WIDTH(self.view)*0.2+30);
    }else
    {
        return 44;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
     NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell*)textField.superview.superview];
    if (index.section==0) {
        switch (index.row) {
            case 1:
                _nickName = textField.text;
                break;
            case 2:
                _miaoshu = textField.text;
                break;
                
            default:
                break;
        }
    }
   
}
#pragma mark - HCGradeManagerTableViewCellDelegate

- (void)HCGradeManagerTableViewCellSelectedTag:(NSInteger)tag
{
    if (tag == self.dataSource.count-1)
    {
        DLog(@"添加了添加按钮");
    }else
    {
        HCFriendMessageInfo *info = self.dataSource[tag];
        DLog(@"点击了某个人---%@", info.nickName);
    }
}

#pragma mark - private methods


#pragma mark - setter or getter

- (UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), WIDTH(self.view)*0.5)];
        [_headImageView addSubview:self.signatureLabel];
    }
    return _headImageView;
}

- (UILabel *)signatureLabel
{
    if (!_signatureLabel)
    {
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT(self.headImageView)-30, WIDTH(self.view), 30)];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        _signatureLabel.font = [UIFont systemFontOfSize:15];
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.text = @"我们的家庭签名~！";
        _signatureLabel.textColor = [UIColor whiteColor];
    }
    return _signatureLabel;
}

#pragma mark - network

- (void)requestGradeManager
{
    
    sigleFamilyMessage *api = [[sigleFamilyMessage alloc]init];
    api.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"][@"FamilyInf"];
            self.info = [HCCreateGradeInfo  mj_objectWithKeyValues:dic];
            //相当于个性签名   这个有问题  一会在解决
            if (isTure) {
                self.info.contactAddr= _miaoshu;
                self.info.familyNickName = _nickName;
                self.info.familyPhoto= _PhotoName;
            }else{
                _miaoshu = self.info.contactAddr;
                _PhotoName = self.info.familyPhoto;
                _nickName = self.info.familyNickName;
            }
            _creatFamilyID = [HCAccountMgr manager].loginInfo.createFamilyId;
        }
        
        NSArray *array = respone[@"Data"][@"row"];
        
        [self.dataSource removeAllObjects];
        
        for (NSDictionary *dic in array)
        {
            HCFriendMessageInfo *friendInfo = [[HCFriendMessageInfo alloc]init];
            friendInfo.userId = dic[@"userId"];
            friendInfo.nickName = dic[@"nickName"];
            friendInfo.imageName = dic[@"imageName"];
            [self.dataSource addObject:friendInfo];
            
        }
        
        self.signatureLabel.text = self.info.familyDescription;
        [self.tableView reloadData];
        NSURL *url = [readUserInfo originUrl:self.info.imageName :kkFamail];
        if (isEditing) {
            self.headImageView.image = choose;
        }else{
            [self.headImageView sd_setImageWithURL:url placeholderImage:IMG(@"head.jpg")];
        }
        self.headImageView.clipsToBounds = YES;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
      
    }];
}
- (void)tapGesture:(UIGestureRecognizer*)recognizer{
    //弹框选择家庭照片
    if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        UIAlertController *myalert =[UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *xiangce = [UIAlertAction actionWithTitle:@"从相册里选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _myPK = [[UIImagePickerController alloc]init];
            _myPK.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //是否允许编辑图片
            _myPK.allowsEditing = YES;
            _myPK.delegate = self;
            [self presentViewController:_myPK animated:YES completion:nil];
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
    }else{
        HCHomeUserPhotoViewController *VC = [[HCHomeUserPhotoViewController alloc]init];
        VC.head_image = self.info.imageName;
        VC.from = @"家庭";
        [self.navigationController pushViewController:VC animated:YES];
    }
    //个人 家庭 头像
   
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    isEditing = YES;
    if (picker==_myPK)
    {
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_myPK dismissViewControllerAnimated:YES completion:nil];
    }else{
        choose = [info objectForKey:UIImagePickerControllerEditedImage];
        [_picker dismissViewControllerAnimated:YES completion:nil];
    }
    [self.tableView reloadData];
    //选择完即上传
    [KLHttpTool uploadImageWithUrl:[readUserInfo url:kkFamail] image:choose success:^(id responseObject) {
        _PhotoName = responseObject[@"Data"][@"files"][0];
        NSDictionary *dict = @{@"photo":_PhotoName};
        //
        [[NSNotificationCenter defaultCenter] postNotificationName:@"修改家庭图片" object:nil userInfo:dict];
            [self showHUDSuccess:@"您已经成功修改了家庭图片"];
            NHCEditingFamilyApi *API = [[NHCEditingFamilyApi alloc]init];
            API.familyNickName = _nickName;
            API.familyId = _creatFamilyID;
            API.ancestralHome = _miaoshu;
            API.imageName = _PhotoName;
            [API startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
                
            }];
    } failure:^(NSError *error) {
        [self showHUDError:@"图片上传失败"];
    }];
    
}
@end
