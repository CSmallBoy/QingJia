//
//  HCCombineFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCombineFamilyViewController.h"
#import "HCCombineFamilyTableViewCell.h"
@interface HCCombineFamilyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    HCCombineFamilyTableViewCell *
    cell;
    NSInteger i;
}

@end

@implementation HCCombineFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"合并家庭的管理";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(bar_buttonClick)];
    self.navigationItem.rightBarButtonItem = rightBar;
}
- (void)bar_buttonClick{
    //此处需要加判断  是否 选中
    UIAlertController *myalert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"剔除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [myalert addAction:delete];
    [myalert addAction:exit];
    [self presentViewController:myalert animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";

    cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil ) {
        cell = [[HCCombineFamilyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.button_select addTarget:self action:@selector(button_select:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row==2) {
        [cell.button_select setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
    }
    return cell;
}
-(void)button_select:(UIButton *)button{
    button.selected =!button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"select_no.png"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
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
