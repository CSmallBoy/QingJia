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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *JDWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.jd.com"]] ;
    
    [JDWebView loadRequest:request];
    
    [self.view addSubview:JDWebView];
    
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
