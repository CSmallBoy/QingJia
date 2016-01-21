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

@interface HCShareViewController ()<UMSocialUIDelegate>

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
//    if(![WXApi isWXAppInstalled])
//    {
//        _weixinBtn.hidden = YES;
//        _pengyouBtn.hidden = YES;
//    }
//    if (![QQApiInterface isQQInstalled])
//    {
//        _qqzonBtn.hidden = YES;
//        _qqzonBtn.hidden = YES;
//    }

}

- (IBAction)backButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//微信好友
- (IBAction)weixin:(UIButton *)sender
{
    [self shareTentceWithTypes:@[UMShareToWechatSession] content:@"M-talk" imageName:@"landingpage_Background" location:nil urlResource:nil];
}

//微信朋友圈
- (IBAction)pengyouBtn:(UIButton *)sender
{
    [self shareTentceWithTypes:@[UMShareToWechatTimeline] content:@"M-talk" imageName:@"landingpage_Background" location:nil urlResource:nil];
}

//腾讯微博
- (IBAction)tengxunweiboBtn:(UIButton *)sender
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToTencent] content:@"M-talk" image:[UIImage imageNamed:@"landingpage_Background"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            DLog(@"分享成功！");
        }
    }];
}

//新浪微博
- (IBAction)sinaWeibo:(UIButton *)sender
{
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        NSLog(@"response is %@",response);
//    });
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1685716127" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"M-talk" image:[UIImage imageNamed:@"landingpage_Background"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess)
//        {
//            DLog(@"分享成功！");
//        }
//    }];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
                    snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1685716127" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToSina] content:@"Mtalk测试" image:OrigIMG(@"landingpage_Background") location:nil urlResource:nil completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            DLog(@"分享成功");
        }
    }];

}

//qq好友
- (IBAction)qqBtn:(UIButton *)sender
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"M-talk" image:[UIImage imageNamed:@"landingpage_Background"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            DLog(@"分享成功！");
        }
    }];
    
}

//qq空间
- (IBAction)qqZone:(UIButton *)sender
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"M-talk" image:[UIImage imageNamed:@"landingpage_Background"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            DLog(@"分享成功！");
        }
    }];
}

//MTalk群聊
- (IBAction)MtalkBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void)shareTentceWithTypes:(NSArray *)array content:(NSString *)content imageName:(NSString *)imageName location:(CLLocation *)location urlResource:(UMSocialUrlResource *)urlResource
{
    NSString *urlStr = @"http://zp.ysrlin.com/gate/html/reg.php";
    [UMSocialWechatHandler setWXAppId:@"wxa3e0f4e53bf74a06" appSecret:@"ed6ce4155f890517f746a2c1445dcb7e" url:urlStr];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:array content:content image:[UIImage imageNamed:imageName] location:location urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            DLog(@"分享成功！");
        }
    }];
}



@end
