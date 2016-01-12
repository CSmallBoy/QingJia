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
//#import "OTCover.h"
#import "HCHomeDetailCommentTableViewCell.h"
#import "HCHomePictureDetailApi.h"

#define HCHomeDetailComment @"HCHomeDetailCommentTableViewCell"

@interface HCHomePictureDetailViewController ()<HCHomeDetailCommentTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//, HCOTCoverDelegate>
{
    BOOL  _isAdd;
    UIImage   *_image;
}
@property (nonatomic, assign) CGFloat commentHeight;
@property(nonatomic,strong)UIImageView *imageView;
//@property (nonatomic, strong) OTCover *otcover;

@end

@implementation HCHomePictureDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图文详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.contentInset =  UIEdgeInsetsMake(200, 0, 0, 0);
    [self createHeaderView];
    
    [self requestPictureDetail];
//    [self setupAnimationHead];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeDetailComment];
    if (!cell)
    {
        cell = [[HCHomeDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HCHomeDetailComment];
    }
    cell.commentBtn.hidden = YES;
    cell.delegate = self;
    cell.info = self.dataSource[indexPath.row];
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
    return self.dataSource.count;
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

#pragma mark - setter or getter

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3*2)];
    }
    return _imageView;
}


#pragma mark - Private methods

-(void)createHeaderView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    HCHomeInfo *info = self.data[@"data"];
    NSInteger index = [self.data[@"index"] integerValue];
     imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info.FTImages[index]]]];
    _image = image;
    imageView.image = image;
    self.imageView = imageView;
    
    [self.tableView insertSubview:self.imageView atIndex:0];
}


-(void)bigView :(UIImageView *)imageView
{
    self.tableView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = self.view.frame;
//        self.view.backgroundColor = [UIColor blackColor];
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
        imageView.backgroundColor = [UIColor clearColor];
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
    
    HCHomePictureDetailApi *api = [[HCHomePictureDetailApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
//            [self.otcover.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
