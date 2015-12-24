//
//  HCGradeSuccessViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeSuccessViewController.h"
#import "ZXingObjC.h" // 二维码

@interface HCGradeSuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *joinMemberBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codingBtn;
@property (weak, nonatomic) IBOutlet UILabel *gradeIdNum;

@end

@implementation HCGradeSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"完成创建";
    [self setupBackItem];
    
    ViewRadius(_joinMemberBtn, 4);
    ViewRadius(_nextBtn, 4);
    
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:@"1234567890"
                                  format:kBarcodeFormatQRCode
                                   width:WIDTH(self.view)
                                  height:WIDTH(self.view)
                                   error:&error];
    if (result)
    {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        [_codingBtn setImage:[UIImage imageWithCGImage:image] forState:UIControlStateNormal];
    }
}



@end
