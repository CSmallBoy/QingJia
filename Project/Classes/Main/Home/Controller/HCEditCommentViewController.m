//
//  HCEditCommentViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentViewController.h"
#import "HCEditCommentInfo.h"
#import "HCEditCommentApi.h"
#import "HCEditCommentView.h"

@interface HCEditCommentViewController ()<HCEditCommentViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HCEditCommentView *contentView;
@property (nonatomic, strong) HCEditCommentInfo *info;

@end

@implementation HCEditCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    [self.view addSubview:self.contentView];
    _info = [[HCEditCommentInfo alloc] init];
    [self.contentView setImageArr:_info.imageArr];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - HCEditCommentViewDelegate

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
    [_info.imageArr removeObjectAtIndex:index];
    [self.contentView setImageArr:_info.imageArr];
}

- (void)hceditCommentViewWithimageButton:(NSInteger)index
{
    if (_info.imageArr.count == index + 1)
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

- (void)hceditCommentViewFeedbackTextViewdidEndEditing
{
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
    
    if (_info.imageArr.count >= 4)
    {
        [self showHUDText:@"最多只能发布3张图片"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [_info.imageArr insertObject:image atIndex:_info.imageArr.count-1];
    
    [self.contentView setImageArr:_info.imageArr];
    
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

- (void)checkCommentData
{
    if (IsEmpty(_info.comments))
    {
        [self showHUDText:@"评论内容不能为空！"];
        return;
    }
    [self requestEditComment];
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

- (void)requestEditComment
{
    HCEditCommentApi *api = [[HCEditCommentApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
        }else
        {
            [self showHUDError:message];
        }
    }];
}



@end
