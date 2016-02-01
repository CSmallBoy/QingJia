//
//  HCRelativeDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRelativeDetailViewController.h"

@interface HCRelativeDetailViewController ()

@end

@implementation HCRelativeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _title_name;
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    UIImageView * head_image = [[UIImageView alloc]initWithFrame:CGRectMake(25, 64+25, SCREEN_WIDTH*0.115, SCREEN_WIDTH*0.115)];
    head_image.image = [UIImage imageNamed:@"image_hea.jpg"];
    [self.view addSubview:head_image];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
