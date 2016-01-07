//
//  HCTaoBaoViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTaoBaoViewController.h"

@interface HCTaoBaoViewController ()

@end

@implementation HCTaoBaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *TaoBaoWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.taobao.com"]] ;
    
    [TaoBaoWebView loadRequest:request];
    [self.view addSubview:TaoBaoWebView];
}
@end
