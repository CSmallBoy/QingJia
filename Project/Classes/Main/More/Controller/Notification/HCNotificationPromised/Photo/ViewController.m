//
//  ViewController.m
//  Images
//
//  Created by 朱宗汉 on 16/2/23.
//  Copyright © 2016年 汪陈陈. All rights reserved.
//

#import "ViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    ZLPhotoPickerViewController *zlpVC = [[ZLPhotoPickerViewController alloc]init];
    zlpVC.callBack = ^(NSArray *arr){
    
    
        for (int i = 0; i<arr.count; i++) {
            
            CGFloat  imageViewW = self.view.frame.size.width/3;
            UIImageView *imageVieW = [[UIImageView  alloc]initWithFrame:CGRectMake(i * imageViewW, 100, imageViewW, 100)];
            ZLPhotoAssets *zlPhoto = arr[i];
            imageVieW.image =  zlPhoto.originImage;
        
            [self.view addSubview:imageVieW];
            
            
        }
        
        
    };
    [self presentViewController:zlpVC animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
