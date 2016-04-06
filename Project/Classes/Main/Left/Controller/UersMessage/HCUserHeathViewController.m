//
//  HCUserHeathViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCUserHeathViewController.h"

@interface HCUserHeathViewController ()<UITextFieldDelegate>

@end

@implementation HCUserHeathViewController

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
    NSArray *arr_detil =@[@"请输入身高",@"请输入体重",@"请输入血型",@"过敏史",@"医疗状况",@"医疗笔记"];
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 40)];
        label.text = arr[indexPath.row];
        UITextField *label2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 5, 150, 40)];
        label2.delegate = self;
        label2.placeholder = arr_detil[indexPath.row];
        [cell addSubview:label2];
        [cell addSubview:label];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell*)textField.superview];
    switch (index.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
}
-(void)getData{
    //上传数据
    NSLog(@"获取数据");
    
}

@end
