//
//  HCShareViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCShareViewController.h"

@interface HCShareViewController ()

@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *pengyouBtn;
@property (weak, nonatomic) IBOutlet UIButton *tengxunBtn;
@property (weak, nonatomic) IBOutlet UIButton *mtalkBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqzonBtn;


@end

@implementation HCShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)backButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
