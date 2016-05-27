//
//  HCFamilyUserInfoViewController.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCFamilyUserInfoViewController.h"

@interface HCFamilyUserInfoViewController ()

@end

@implementation HCFamilyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor = [UIColor greenColor];
    UIButton *back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_button setFrame:CGRectMake(10, 30, 30, 30)];
    [back_button setImage:[UIImage imageNamed:@"barItem-back"] forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:back_button];
    self.tableView.tableHeaderView = view;
    // Do any additional setup after loading the view.
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"indetifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
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
