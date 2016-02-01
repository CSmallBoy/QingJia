//
//  HCHeathViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHeathViewController.h"

@interface HCHeathViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HCHeathViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"医疗急救卡";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self getData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = @[@"身高",@"体重",@"血型",@"过敏史",
                  @"医疗状况",@"医疗笔记"];
    NSArray *arr_detil =@[@"167cm",@"50Kg",@"B型",@"无",@"良好",@"无"];
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 40)];
        label.text = arr[indexPath.row];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 80, 40)];
        label2.text = arr_detil[indexPath.row];
        [cell addSubview:label2];
        [cell addSubview:label];
    }
    return cell;
}
-(void)getData{
    NSLog(@"获取数据");
    
}

@end
