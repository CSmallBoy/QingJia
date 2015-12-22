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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"案例详情";
    [self.view addSubview:self.webview];
    [self setupBackItem];
}

-(UIWebView *)webview
{
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]] ;
        
        [_webview loadRequest:request];
    }
    return _webview;
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
