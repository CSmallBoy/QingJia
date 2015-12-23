//
//  HCVenderMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/9.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAvatarMgr.h"
#import "HCVatarUploadApi.h"

static HCAvatarMgr *_sharedManager = nil;

@interface HCAvatarMgr()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, copy) void(^uploadCompletionBlock) (BOOL result, UIImage *image, NSString *msg);
@property (nonatomic, copy) void(^uploadPhotoCompletionBlock) (BOOL result, NSDictionary *data, NSString *msg);
@property (nonatomic, weak) UIViewController *delegate;

@end

@implementation HCAvatarMgr

//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAvatarMgr alloc] init];
    });
    
    return _sharedManager;
}

- (void)modifyAvatarWithController:(UIViewController *)vc
                        completion:(void (^)(BOOL result, UIImage *image, NSString *msg))completion
{
    self.delegate = vc;
    self.uploadCompletionBlock = completion;
    
    [self showActionSheet];
}

- (void)modifyPhotoWithController:(UIViewController *)vc
                       completion:(void (^)(BOOL result, NSDictionary *data, NSString *msg))completion
{
    self.delegate = vc;
    self.uploadPhotoCompletionBlock = completion;
    
    [self showActionSheet];
}

#pragma mark - action

- (void)showActionSheet
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [action showInView:keyWindow];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        //NSLog(@"拍照");
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        //NSLog(@"从手机相册选择");
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        return;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    [[picker navigationBar] setTintColor:[UIColor whiteColor]];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self.delegate presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==	 UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_isUploadImage)
    {
        image = [self imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
    }
    self.headImage = image;
    
    if (_isUploadImage && !_noUploadImage)
    {
        [self uploadHeadImage:image];
    }else if(!_isUploadImage && !_noUploadImage)
    {
        [self uploadPhotoImage:image];
    }else if (_noUploadImage)
    {
        self.uploadCompletionBlock(YES, self.headImage, @"");
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - network upload image

- (void)uploadPhotoImage:(UIImage *)image
{
    HCVatarUploadApi *api = [[HCVatarUploadApi alloc] init];
    api.Argument = @{@"t": @"User,logout", @"token": @"23"};
    api.image = image;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSDictionary *data) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            self.uploadPhotoCompletionBlock(YES, data, message);

        }
        
    }];
}

- (void)uploadHeadImage:(UIImage *)headImage
{
    HCVatarUploadApi *api = [[HCVatarUploadApi alloc] init];
    api.image = headImage;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSDictionary *data) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            //保存到数据库
//            [HCAccountMgr manager].loginInfo.avatar = data[@"url"];
//            [[HCAccountMgr manager] updateLoginInfoToDB];
        }
        self.uploadCompletionBlock(YES,self.headImage,message);
    }];
}

@end
