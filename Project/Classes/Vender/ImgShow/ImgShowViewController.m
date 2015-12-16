//
//  ImgShowViewController.m
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "ImgShowViewController.h"
#import "MRImgShowView.h"

@interface ImgShowViewController ()

@end

@implementation ImgShowViewController

- (id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index{
    
    self = [super init];
    if (self) {
        [self init];
        _data = [data retain];
        _index = index;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc{
    
    [_data release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(0, 0, 0, 0.7);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatImgShow];
}

// 初始化视图
- (void)creatImgShow{
    
    MRImgShowView *imgShowView = [[MRImgShowView alloc] initWithFrame:self.view.frame];
    imgShowView.isNetLoadImage = self.isNetLoadImage;
    [imgShowView imageShowViewWithSourceData:_data withIndex:_index];
    
    
    // 解决谦让
    [imgShowView requireDoubleGestureRecognizer:[[self.view gestureRecognizers] lastObject]];
    
    [self.view addSubview:imgShowView];
}

#pragma mark -UIGestureReconginzer
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
