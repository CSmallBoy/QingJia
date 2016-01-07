//
//  HCCaseDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCaseDetailViewController.h"

@interface HCCaseDetailViewController ()
@property (nonatomic,strong) UIWebView *webview;
@end

@implementation HCCaseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"案例详情";
    [self.view addSubview:self.webview];
    [self setupBackItem];
}

#pragma mark ---Setter Or Getter

-(UIWebView *)webview
{
    if (!_webview)
    {
        _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]] ;
        
        [_webview loadRequest:request];
    }
    return _webview;
}



@end
