//
//  HCPromisedReportController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedReportController.h"

#import "HCFeedbackTextView.h"
#import "HCReportApi.h"

#import "ZLPhotoAssets.h"
#import "ZLPhotoPickerViewController.h"

@interface HCPromisedReportController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIView * upView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UITableView *smallTableView;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) NSArray  *chooseArr;
@property (nonatomic, strong)HCFeedbackTextView *textView;//输入框
@property (nonatomic, strong)NSMutableArray *imagesArr;//图片组
@property (nonatomic, strong)NSMutableArray *imagesStrArr;//图片字符组

@end

@implementation HCPromisedReportController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"举报";
    [self setupBackItem];
    self.view.backgroundColor = COLOR(221, 221, 221, 1);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.view addSubview:self.upView];
    [self.view addSubview:self.bottomView];

}

#pragma mark --- tableViewDelegate  and dataScource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chooseArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"smallChooseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.textLabel.text = self.chooseArr[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.button setTitle:self.chooseArr[indexPath.row] forState:UIControlStateNormal];
    [tableView removeFromSuperview];
}


#pragma mark private mothods

-(void)send:(UIBarButtonItem *)right
{
    if ([[_textView.textView.text substringFromIndex:5] length] > 0)
    {
        [self showHUDView:@"举报中"];
        if (_imagesArr.count > 0)
        {
            [self postImagesToService:1];
        }
        else
        {
            [self postReporToService];
        }
    }
    else
    {
        [self showHUDText:@"请输入举报详情描述"];
    }

}

-(void)choose:(UIButton *)button
{
   
    [self.view addSubview:self.smallTableView];
    
}

//添加照片
- (void)addImagesToView
{
    [self.imagesArr removeAllObjects];
    for (UIView *view in self.bottomView.subviews)
    {
        if (view.tag == 100 || view.tag == 101 || view.tag == 102)
        {
            [view removeFromSuperview];
        }
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"添加照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
    [sheet showInView:self.view];
}

#pragma mark ---- UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            [[picker navigationBar] setTintColor:[UIColor whiteColor]];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            ZLPhotoPickerViewController *zlpVC = [[ZLPhotoPickerViewController alloc]init];
            zlpVC.maxCount = 3;
            zlpVC.callBack = ^(NSArray *arr){
                for (ZLPhotoAssets *zl in arr)
                {
                    UIImage  *image = zl.originImage;
                    [self.imagesArr addObject:image];
                }
                for (int i = 0; i< self.imagesArr.count; i++)
                {
                    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90 +80*i, 180, 60, 60)];
                    imageView.userInteractionEnabled = YES;
                    imageView.image = self.imagesArr[i];
                    UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deletePhoto:)];
                    [imageView addGestureRecognizer:longPress];
                    imageView.tag = 100+i;
                    [self.bottomView addSubview:imageView];
                }
            };
            [self presentViewController:zlpVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.imagesArr removeAllObjects];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imagesArr addObject: image];
    
    for (int i = 0; i< self.imagesArr.count; i++)
    {
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90 +80*i, 180, 60, 60)];
        imageView.image = self.imagesArr[i];
        UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deletePhoto:)];
        [imageView addGestureRecognizer:longPress];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        [self.bottomView addSubview:imageView];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark getter- setter

- (UIView *)upView
{
    if(!_upView){
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,80/667.0 *SCREEN_HEIGHT)];
        _upView.backgroundColor = COLOR(241, 241, 241, 1);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 10, 15, 15)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = IMG(@"report");
        imageView.tintColor = COLOR(62, 134, 224, 1);
        
        
        [_upView addSubview:imageView];
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 10, 50, 15)];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = @"举报原因";
        label.textColor = COLOR(62, 134, 224, 1);
        [_upView addSubview:label];
        
        _button =[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(30, CGRectGetMaxY(label.frame) + 10, SCREEN_WIDTH-60, 30);
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [UIColor blackColor].CGColor;
        [_button setTitle:@"不文明内容" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *sanjiaoIV = [[UIImageView alloc]initWithFrame:CGRectMake(_button.frame.size.width-20, 10, 10, 10)];
        sanjiaoIV.image = IMG(@"sanjiao");
        
        [_button addSubview:sanjiaoIV];
    
        [_upView addSubview:_button];
        
        
    }
    return _upView;
}


- (UIView *)bottomView
{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame)+10, SCREEN_WIDTH,260)];
        _bottomView.backgroundColor = COLOR(241, 241, 241, 1);
        
        _textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _textView.textView.text = @"描述详情:";
        _textView.textView.textColor = [UIColor blackColor];
        _textView.textView.backgroundColor = COLOR(241, 241, 241, 1);
        
        [_bottomView addSubview:_textView];
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10,180, 60, 60);
        [button setBackgroundImage:IMG(@"Add-Images") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addImagesToView) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 60, 20)];
        label.font= [UIFont systemFontOfSize:12];
        label.text = @"添加图片";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        [_bottomView addSubview:label];
                                    
        
    }
    return _bottomView;
}



- (UITableView *)smallTableView
{
    if(!_smallTableView){
         CGRect  startFrame = [self.button convertRect:self.button.bounds toView:self.view];
        _smallTableView = [[UITableView alloc]initWithFrame:CGRectMake(startFrame.origin.x, CGRectGetMaxY(startFrame), startFrame.size.width, 150) style:UITableViewStylePlain];
        
        _smallTableView.delegate = self;
        _smallTableView.dataSource = self;
    }
    return _smallTableView;
}



- (NSArray *)chooseArr
{
    if(!_chooseArr){
        _chooseArr = @[@"暴力",@"血腥",@"黄色淫秽",@"虚假信息",@"传销",@"其他"];
    }
    return _chooseArr;
}

- (NSMutableArray *)imagesArr
{
    if (_imagesArr == nil)
    {
        self.imagesArr = [NSMutableArray array];
    }
    return _imagesArr;
}

- (NSMutableArray *)imagesStrArr
{
    if (_imagesStrArr == nil)
    {
        self.imagesStrArr = [NSMutableArray array];
    }
    return _imagesStrArr;
}


#pragma mark - Networking

- (void)postReporToService
{
    NSString *imageNames = [self.imagesStrArr componentsJoinedByString:@","];
    HCReportApi *api = [[HCReportApi alloc] init];
    api.callId = self.callId;
    api.content = [_textView.textView.text substringFromIndex:5];
    api.imageNames = imageNames;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        NSLog(@"++++%@", respone);
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            [self showHUDText:@"您已经举报成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showHUDText:respone[@"message"]];
        }
    }];
    
}

- (void)postImagesToService:(int)num
{
    if (num > self.imagesArr.count) {
        
        [self postReporToService];
        
        return;
    }
    UIImage *image = self.imagesArr[num-1];
    NSString *token = [HCAccountMgr manager].loginInfo.Token;
    NSString *uuid = [HCAccountMgr manager].loginInfo.UUID;
    NSString *str = [kUPImageUrl stringByAppendingString:[NSString stringWithFormat:@"fileType=%@&UUID=%@&token=%@",kkReport,uuid,token]];
    [KLHttpTool uploadImageWithUrl:str image:image success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *imgStr = responseObject[@"Data"][@"files"][0];
        [self.imagesStrArr addObject:imgStr];
        int newNum = num +1;
        [self postImagesToService:newNum];
        
    } failure:^(NSError *error) {
        [self showHUDError:@"图片上传失败"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
