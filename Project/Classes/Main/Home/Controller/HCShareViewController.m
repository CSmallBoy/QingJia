//
//  HCShareViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCShareViewController.h"

#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSinaSSOHandler.h"

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
    if(![WXApi isWXAppInstalled])
    {
        _weixinBtn.hidden = YES;
        _pengyouBtn.hidden = YES;
    }
    if (![QQApiInterface isQQInstalled])
    {
        _qqzonBtn.hidden = YES;
        _qqzonBtn.hidden = YES;
    }

}
- (IBAction)backButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
