//
//  HCBindTagController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCBindTagController.h"

@interface HCBindTagController ()

@end

@implementation HCBindTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定标签";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonClick:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 120;
    }
    else if (indexPath.row == 1)
    {
        return 250;
    }
    else
    {
        return 220;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bindTagID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    
    if (indexPath.row == 0)
    {
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-35), 10, 70, 70)];
        imageView.image = IMG(@"2Dbarcode");
        [cell addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 90, 80, 20)];
        label.text = [NSString stringWithFormat:@"ID:%@",@"12345678"];
        [cell addSubview:label];
        
    }
    else if (indexPath.row ==1)
    {
        cell.backgroundColor = [UIColor yellowColor];
    }else
    {
        cell.backgroundColor = [UIColor grayColor];
    }
    
    
    return cell;

 
}

#pragma mark --- provite mothods
// 点击了确定按钮
-(void)sureButtonClick:(UIBarButtonItem *)right
{
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
