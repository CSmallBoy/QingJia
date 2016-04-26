//
//  HCEditCommentViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentViewController.h"
#import "HCHomeInfo.h"
#import "HCEditCommentInfo.h"
#import "HCEditCommentApi.h"
#import "HCImageUploadApi.h"
#import "HCImageUploadInfo.h"
#import "HCEditCommentView.h"
//评论api
#import "NHCHomeCommentsApi.h"
//上传图片的api
#import "NHCHomeSingleFigureApi.h"

@interface HCEditCommentViewController ()<HCEditCommentViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HCEditCommentView *contentView;
@property (nonatomic, strong) HCEditCommentInfo *info;
@property (nonatomic, strong) NSArray *FTImages;

@end

@implementation HCEditCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    [self.view addSubview:self.contentView];
    _info = [[HCEditCommentInfo alloc] init];
    [self.contentView setImageArr:_info.FTImages];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - HCEditCommentViewDelegate的代理方法
//根据第几个button去执行相应的操作

- (void)hceditCommentViewWithButtonIndex:(NSInteger)index
{
    if (index)
    {
        [self handleTapGestureRecognizer:nil];
    }else
    {
        [self checkCommentData];
    }
}

- (void)hceditCommentViewWithDeleteImageButton:(NSInteger)index
{
    [_info.FTImages removeObjectAtIndex:index];
    [self.contentView setImageArr:_info.FTImages];
}

- (void)hceditCommentViewWithimageButton:(NSInteger)index
{
    if (_info.FTImages.count == index + 1)
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [action showInView:self.view];
    }
}

- (void)hceditCommentViewFeedbackTextViewdidBeginEditing
{
    CGRect frame = self.contentView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(frame.origin.x, 64, WIDTH(self.view)-20, HEIGHT(self.view)*0.5);
    }];
    
}

- (void)hceditCommentViewFeedbackTextViewdidEndEditingWithText:(NSString *)text
{
    _info.FTContent = text;
    CGRect frame = self.contentView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(frame.origin.x, 0, WIDTH(self.view)-20, HEIGHT(self.view)*0.5);
        _contentView.center = CGPointMake(self.view.center.x, self.view.center.y);
    }];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) // 拍照
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        //        [[picker navigationBar] setTintColor:[UIColor whiteColor]];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (buttonIndex == 1) // 相册
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        //        [[picker navigationBar] setTintColor:[UIColor whiteColor]];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (_info.FTImages.count >= 4)
    {
        [self showHUDText:@"最多只能发布3张图片"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [_info.FTImages insertObject:image atIndex:_info.FTImages.count-1];
    
    [self.contentView setImageArr:_info.FTImages];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self.view];
    if (!CGRectContainsPoint(self.contentView.frame, tapPoint))
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//检查评论内容
- (void)checkCommentData
{
    if (IsEmpty(_info.FTContent))
    {
        [self showHUDText:@"评论内容不能为空！"];
        return;
    }
    if (_info.FTImages.count > 1)
    {
        //图片上传
        // [self requestImageUpload];
    }else
    {
        if ([_single isEqualToString:@"评论单图"]) {
            //单图评
            [self resquestCommentS];
        }
        else if ([_single isEqualToString:@"评论单图的回复"]){
            //重新下一个回复  别人评论的方法
            [self resquestCommentTo];
        }else if (IsEmpty(_all_coment_to)){
            //所有的
             [self requestEditComment];
        }else  {
            //单图评
            //[self resquestCommentS];
            // 下一种评论情况
           
        }
    }
    
}

- (void)handleBackButton
{
    [self handleTapGestureRecognizer:nil];
}

#pragma mark - setter or getter

- (HCEditCommentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[HCEditCommentView alloc] initWithFrame:CGRectMake(10, 0, WIDTH(self.view)-20, HEIGHT(self.view)*0.5)];
        _contentView.delegate = self;
        _contentView.center = CGPointMake(self.view.center.x, self.view.center.y);
        ViewRadius(_contentView, 5);
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

#pragma mark - network

- (void)resquestCommentTo{
    NHCHomeSingleFigureApi *api  = [[NHCHomeSingleFigureApi alloc]init];
    
    api.TimeID = _time_id;
    //api.toUser = _infomodel.creator;
    api.Content = _info.FTContent;
    api.parentCommentId = _commentId;
    //int a = [_image_number intValue];
    api.ToimageName = _image_name;
    api.toUser = _touser;
    ///还没有写完
    
    
    
    
    
    //这个地方要  timeId   ImageName  to_UserID Contact
    
    if (_info.FTImages.count==1) {
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            if (requestStatus == HCRequestStatusSuccess) {
                [self showHUDSuccess:@"评论成功"];
            }
        }];
    }else{
        //这个地方是判断是否有图片的
 
    }
}
//回复的api
//单图的api
-(void)resquestCommentS{
 //只有文字的时候上传
    
    
    NHCHomeSingleFigureApi *api  = [[NHCHomeSingleFigureApi alloc]init];
    HCHomeInfo *homeinfo = self.data[@"data"];
    api.TimeID = homeinfo.TimeID;
    api.toUser = homeinfo.creator;
    api.Content = _info.FTContent;
    api.parentCommentId = @"0";
    NSString *str = self.data[@"index"];
    int a = [str intValue];
    api.ToimageName = homeinfo.FTImages[a];
    if (_info.FTImages.count==1) {
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            if (requestStatus == HCRequestStatusSuccess) {
                [self showHUDSuccess:@"评论成功"];
            }
        }];
    }else{//这个有图片  需要先上传图片
        
        
        //有图片就执行这个操作
        //第一步 上传图片
        //第二部整合 图片名字
        NSMutableArray *arr_image_path = [NSMutableArray array];
        for (int i = 0; i < _info.FTImages.count-1; i ++) {
            [KLHttpTool uploadImageWithUrl:[readUserInfo url:kkComment] image:_info.FTImages[i] success:^(id responseObject) {
                NSString *str1 = responseObject[@"Data"][@"files"][0];
                [arr_image_path addObject:str1];
                NSString *str2;
                NSString *str_all = [NSMutableString string];
                if (arr_image_path.count == _info.FTImages.count-1) {
                    for (int i = 0 ; i < arr_image_path.count ; i ++) {
                        if (i == 0) {
                            str2 = arr_image_path[0];
                            str_all = [str2 stringByAppendingString:str_all];
                        }else{
                            str2 = [arr_image_path[i] stringByAppendingString:@","];
                            str_all = [str2 stringByAppendingString:str_all];
                        }
                    }
                }
                [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
                    NSLog(@"%@",responseObject);
                }];
            } failure:^(NSError *error) {
                
            }];
        }

    }
}
//所有的
- (void)requestEditComment
{
    [self showHUDView:nil];
    NHCHomeCommentsApi *api  = [[NHCHomeCommentsApi alloc]init];
    HCHomeInfo *homeInfo = self.data[@"data"];
    api.Timesid = homeInfo.TimeID;
    api.ToUserId =homeInfo.creator;
    api.content = _info.FTContent;
    //先判断是否有图片上传
    if (_info.FTImages.count==1) {
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
            if (requestStatus == HCRequestStatusSuccess)
            {
                [self showHUDSuccess:@"评论成功"];
                [self performSelector:@selector(handleBackButton) withObject:nil afterDelay:0.6];
            }else
            {
                [self showHUDError:message];
            }
            
        }];
    }else{
        //有图片就执行这个操作
        //第一步 上传图片
        //第二部整合 图片名字
        NSMutableArray *arr_image_path = [NSMutableArray array];
        for (int i = 0; i < _info.FTImages.count-1; i ++) {
            [KLHttpTool uploadImageWithUrl:[readUserInfo url:kkComment] image:_info.FTImages[i] success:^(id responseObject) {
                NSString *str1 = responseObject[@"Data"][@"files"][0];
                [arr_image_path addObject:str1];
                NSString *str2;
                NSString *str_all = [NSMutableString string];
                if (arr_image_path.count == _info.FTImages.count-1) {
                    for (int i = 0 ; i < arr_image_path.count ; i ++) {
                        if (i == 0) {
                            str2 = arr_image_path[0];
                            str_all = [str2 stringByAppendingString:str_all];
                        }else{
                            str2 = [arr_image_path[i] stringByAppendingString:@","];
                            str_all = [str2 stringByAppendingString:str_all];
                        }
                    }
                }
                [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
                    NSLog(@"%@",responseObject);
                }];
            } failure:^(NSError *error) {
                
            }];
        }
        
        
    }
    
   
    
//    HCEditCommentApi *api = [[HCEditCommentApi alloc] init];
//    HCHomeInfo *homeInfo = self.data[@"data"];
//    _info.FTID = homeInfo.KeyId;
//    api.commentInfo = _info;
//    api.FTImages = _FTImages;
//    
//    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
//        if (requestStatus == HCRequestStatusSuccess)
//        {
//            [self showHUDSuccess:@"评论成功"];
//            [self performSelector:@selector(handleBackButton) withObject:nil afterDelay:0.6];
//        }else
//        {
//            [self showHUDError:message];
//        }
//    }];
}

- (void)requestImageUpload
{
    [self showHUDView:nil];
    
    HCImageUploadApi *api = [[HCImageUploadApi alloc] init];
     api.fileType = @"MTimes";
    
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:_info.FTImages.count-1];
    for (NSInteger i = 0; i < _info.FTImages.count-1; i++)
    {
        [imageArr addObject:_info.FTImages[i]];
    }
    api.FTImages = imageArr;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            NSMutableArray *ImageNameArr = [NSMutableArray arrayWithCapacity:array.count];
            for (HCImageUploadInfo *info in array)
            {
                [ImageNameArr addObject:info.FileName];
            }
            _FTImages = ImageNameArr;
            [self requestEditComment];
        }else
        {
            [self showHUDError:@"图片上传失败!"];
        }
    }];
}



@end
