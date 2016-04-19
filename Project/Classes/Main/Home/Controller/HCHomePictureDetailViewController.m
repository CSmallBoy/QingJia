//
//  HCHomePictureDetailViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomePictureDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MultiFormat.h" // 同步加载图片了
#import "HCHomeInfo.h"
#import "HCHomeDetailCommentTableViewCell.h"
#import "HCHomePictureDetailApi.h"
//评论视图
#import "HCEditCommentView.h"
#import "HCEditCommentViewController.h"
//单图pingl
#import "NHCHomeSingleFigureApi.h"
//单张图的评论列表
#import "NHCHomeCommentListApi.h"
#import "HCHomeDetailInfo.h"
#define HCHomeDetailComment @"HCHomeDetailCommentTableViewCell"

@interface HCHomePictureDetailViewController ()<HCHomeDetailCommentTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL  _isAdd;
    UIImage   *_image;
  
}
@property (nonatomic, strong) HCEditCommentView *contentView;
@property (nonatomic, strong) HCHomeInfo *info;
@property (nonatomic, strong) HCHomeDetailInfo *detailInfo;
@property (nonatomic, assign) CGFloat commentHeight;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *commentbutton;

@end

@implementation HCHomePictureDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图文详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    _info = self.data[@"data"];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.contentInset =  UIEdgeInsetsMake(200, 0, 0, 0);
    [self createHeaderView];
    
    [self.view addSubview:[self button]];
    [self requestPictureDetail];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeDetailComment];
    if (!cell)
    {
        cell = [[HCHomeDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HCHomeDetailComment];
    }
    cell.commentBtn.hidden = NO;
    cell.delegate = self;
    cell.info = _detailInfo.commentsArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detailInfo.commentsArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _commentHeight + 70;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"%lf",self.tableView.contentOffset.y);
    
    
    if (self.tableView.contentOffset.y<=- SCREEN_HEIGHT/3*2) {
        
        self.navigationController.navigationBarHidden = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3*2)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        imageView.image = _image;
        if (!_isAdd) {
            [self.view addSubview:imageView];
            [self bigView:imageView];
            _isAdd = YES;
            
        }
    }
    else
    {
     _imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH , self.tableView.contentOffset.y);
    }
    
   
}


#pragma mark - HCHomeDetailCommentTableViewCellDelegate

- (void)hchomeDetailCommentTableViewCellCommentHeight:(CGFloat)commentHeight
{
    _commentHeight = commentHeight;
    DLog(@"commentHeight--%@", @(_commentHeight));
}

#pragma mark - HCOTCoverDelegate

- (void)hcotcoreSelectedImageView
{
    DLog(@"点击了头部图片");
}

#pragma mark - setter or getter  评论按钮  评论视图

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3*2)];
    }
    return _imageView;
}
- (UIButton *)button{
    if (!_commentbutton) {
        _commentbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentbutton setFrame:CGRectMake(0, SCREEN_HEIGHT- 49, SCREEN_WIDTH, 49)];
        [_commentbutton setBackgroundColor:[UIColor orangeColor]];
        [_commentbutton setTitle:@"评论" forState:UIControlStateNormal];
        _commentbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_commentbutton addTarget:self  action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentbutton;
}

#pragma mark - 评论点击事件
-(void)commentClick{
    
    //评论界面
    HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
    editComment.data = @{@"data": _info,@"index":self.data[@"index"]};
    UIViewController *rootController = self.view.window.rootViewController;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        editComment.modalPresentationStyle=
        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    }else
    {
        rootController.modalPresentationStyle=
        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    }
    editComment.single = @"评论单图";
    [rootController presentViewController:editComment animated:YES completion:nil];
}
#pragma mark - Private methods
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

    }else
    {
        //[self requestEditComment];
    }
}


-(void)createHeaderView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    HCHomeInfo *info = self.data[@"data"];
    NSInteger index = [self.data[@"index"] integerValue];
     imageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *image_url = info.FTImages[index];
//    UIImage *image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info.FTImages[index]]]];
//    _image = image;
//    imageView.image = image;
    [imageView sd_setImageWithURL:[readUserInfo originUrl:image_url :kkTimes] placeholderImage:IMG(@"1.png")];
    self.imageView = imageView;
    [self.tableView insertSubview:self.imageView atIndex:0];
}


-(void)bigView :(UIImageView *)imageView
{
    self.tableView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        //imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = self.view.frame;
        imageView.image = self.imageView.image;
        self.view.backgroundColor = [UIColor blackColor];
    }completion:^(BOOL finished) {
        UIButton  *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44);
        saveButton.backgroundColor = RGBCOLOR(8, 19, 34);
        [saveButton setTitle:@"保存到手机" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(savePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [imageView addSubview:saveButton];
    }];
}
//手势方法
-(void)tap:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden = NO;
    [tap.view removeAllSubviews];
    [UIView animateWithDuration:0.5 animations:^{
        tap.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, 200);
    }completion:^(BOOL finished) {
        UIImageView *imageView = (UIImageView*)tap.view;
        //imageView.backgroundColor = [UIColor clearColor];
        imageView  = self.imageView;
        [tap.view removeFromSuperview];
    }];
    _isAdd = NO;
    self.tableView.hidden = NO;
}

//保存按钮的点击方法
-(void)savePhoto:(UIButton *)button
{
    UIImageView *imageView = (UIImageView *)button.superview;
    UIImage *image = imageView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [self showHUDError:@"保存失败"];
       
    } else  {
        [self showHUDSuccess:@"保存成功"];
   
    }
}

#pragma mark - network

- (void)requestPictureDetail
{
    [self showHUDView:nil];
    NHCHomeCommentListApi *api2 = [[NHCHomeCommentListApi alloc]init];
    int a = [self.data[@"index"] intValue];
    api2.TimeID = _info.TimeID;
    api2.imageName = _info.FTImages[a];
    [api2 startRequest:^(HCRequestStatus requestStatus, NSString *message, HCHomeDetailInfo *info) {
        [self hideHUDView];
        [self.dataSource removeAllObjects];
        _detailInfo = info;
        [self.tableView reloadData];
        
    }];
}


@end
