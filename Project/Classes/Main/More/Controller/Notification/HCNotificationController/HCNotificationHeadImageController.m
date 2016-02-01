//
//  HCNotificationHeadImageController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/28.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNotificationHeadImageController.h"

@interface HCNotificationHeadImageController ()

@property (nonatomic,strong) UIImageView   *imageView;
@property (nonatomic,strong) UIView        *blackView;
@end

@implementation HCNotificationHeadImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.frame = CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT);
     self.title = @"头像";
    [self setupBackItem];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.blackView];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark --- getter Or setter


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -100, SCREEN_HEIGHT-300)];
        _imageView.center = self.view.center;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = self.data[@"image"];
        
        _imageView.image = image;
    }
    return _imageView;
}



- (UIView *)blackView
{
    if(!_blackView){
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
        _blackView.backgroundColor = [UIColor blackColor];
    }
    return _blackView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


@end
