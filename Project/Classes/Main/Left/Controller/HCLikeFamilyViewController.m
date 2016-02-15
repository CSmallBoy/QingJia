//
//  HCLikeFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLikeFamilyViewController.h"
#import "HCLikeFamilyTableViewCell.h"
@interface HCLikeFamilyViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HCLikeFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}
- (void)makeUI{
    [self setupBackItem];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    HCLikeFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[HCLikeFamilyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.label.text = [NSString stringWithFormat:@"家族名字%ld",indexPath.row];
    cell.label2.text = @"申请加入";
    cell.label2.textColor = [UIColor redColor];
    ViewBorderRadius(cell.label2, 3, 1, CLEARCOLOR);
    if (indexPath.row==6) {
        [cell.label2 removeFromSuperview];
        UILabel *label3 = [[UILabel  alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.75-10, 3,SCREEN_WIDTH*0.25, 39)];
        label3.text = @"已申请加入";
        label3.textColor = [UIColor grayColor];
        [cell addSubview:label3];
    }
    return cell;
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
