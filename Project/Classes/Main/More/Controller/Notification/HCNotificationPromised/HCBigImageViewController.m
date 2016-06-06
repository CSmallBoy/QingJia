//
//  HCBigImageViewController.m
//  钦家
//
//  Created by Tony on 16/6/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCBigImageViewController.h"
#import "HCSavePhotoToAblumMgr.h"

@interface HCBigImageViewController ()

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *saveButton;

@end

@implementation HCBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"图片详情";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageView];
    [self.imageView addSubview:self.saveButton];
}


- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _imageView.image = self.image;
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)saveButton
{
    if (_saveButton == nil)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(0, HEIGHT(_imageView) - 50, SCREEN_WIDTH, 50);
        _saveButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
        [_saveButton setTitle:@"保存到手机" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveImageToAblum) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _saveButton;
}

- (void)saveImageToAblum
{
    NSString *string = [[HCSavePhotoToAblumMgr shareManager] saveImageToAblum:self.image];
    [self showHUDText:string];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
