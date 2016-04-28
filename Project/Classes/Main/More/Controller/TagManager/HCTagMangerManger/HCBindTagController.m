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

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray * objectArr;
@property (nonatomic,assign) NSInteger  index;
@property (nonatomic,strong) HCNewTagInfo *seletedInfo;
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *nomalLabel;

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *imgStr;


@end

@implementation HCBindTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定标签";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    self.index = 0;
    
    [self requestObjectData]; // 获得所有的对象
    
    self.tableView.tableHeaderView =HCTabelHeadView(0.1);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonClick:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 240;
    }
    else
    {
        return 290;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bindTagID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    
    if (indexPath.row == 0)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"ID:%@",self.labelGuid];
        [cell addSubview:label];
        
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-40), 70, 80, 80)];
        imageView.image = IMG(@"2Dbarcode");
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [cell addSubview:imageView];
        
        UILabel *upImgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, 20)];
        upImgLabel.textColor = [UIColor blackColor];
        upImgLabel.text = @"上传标签图片";
        upImgLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:upImgLabel];
        
        [cell addSubview:self.textField];
        
    }
    else if (indexPath.row ==1)
    {
        
        for (int i  = 0;i<self.objectArr.count;i++) {
            
            HCNewTagInfo *info = self.objectArr[i];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 230)];
            view.backgroundColor = kHCNavBarColor;
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 210)];
            NSURL *url = [readUserInfo originUrl:info.imageName :kkObject];
            [imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
            
            [view addSubview:imageView];
            
            [self.scrollView addSubview:view];
            
        }
        
        [cell addSubview:self.scrollView];
        self.nameLabel.text = self.seletedInfo.trueName;
        [cell addSubview:self.nameLabel];
        [cell addSubview:self.nomalLabel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

 
}

#pragma mark --- UIScrollViewDelegate



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.tableView) {
        CGFloat offset = scrollView.contentOffset.x;
        NSLog(@"%f",offset);
        self.index = offset/SCREEN_WIDTH;
        
        NSLog(@"%ld",self.index);
        
        self.seletedInfo = self.objectArr[self.index];
        self.nameLabel.text = self.seletedInfo.trueName;
    }
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
        [self showHUDText:@"标签名字"];
        return;
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

- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    
    }
    return _scrollView;
}


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
        _nomalLabel.text = @"选择绑定为标签试用者";
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
// 获得所有的对象
-(void)requestObjectData
{
    HCObjectListApi *api = [[HCObjectListApi alloc]init];

    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
       
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSArray *array =respone[@"Data"][@"rows"];
            for (NSDictionary *dic in array) {
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues: dic];
                [self.objectArr addObject:info];
            }
            if (self.objectArr.count >0) {
                self.seletedInfo = self.objectArr[0];
                self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.objectArr.count), 230);
                NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        
    }];
}

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

-(void)upLoadData
{
    HCTagActivateApi *api = [[HCTagActivateApi alloc]init];
    
    NSString *str = [NSString stringWithFormat:@"%d",arc4random()%10000];
    
//    api.labelGuid = [NSString stringWithFormat:@"8f0a-4aed-%@",str ];
    api.labelGuid = self.labelGuid;
    api.imageName = self.imgStr;
    api.labelTitle = self.textField.text;
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
