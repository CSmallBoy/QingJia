//
//  HCJDBuyViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCJDBuyViewController.h"

@interface HCJDBuyViewController ()

@end

@implementation HCJDBuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    UIWebView *JDWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.jd.com"]] ;
    [JDWebView loadRequest:request];
    [self.view addSubview:JDWebView];
    
}
@end
