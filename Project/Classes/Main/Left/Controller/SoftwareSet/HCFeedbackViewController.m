//
//  HCFeedbackViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFeedbackViewController.h"

#import "HCFeedbackTextView.h"

@interface HCFeedbackViewController ()


@end

@implementation HCFeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"反馈建议";
    [self setupBackItem];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
}

#pragma mark --- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 50;
    }
    else
    {
        return SCREEN_HEIGHT-44-50-100-64;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID =@"suggestionID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (indexPath.row == 0) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 20)];
        textField.placeholder = @"联系方式（手机号或者E-mail）";
        [cell.contentView addSubview:textField];
    }else
    {
        HCFeedbackTextView *textView = [[HCFeedbackTextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20,SCREEN_HEIGHT-44-50-100-64-20)];
        textView.placeholder = @"反馈内容";
        [cell.contentView addSubview:textView];
       
    }
   
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    view.backgroundColor =  kHCBackgroundColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15,35 , SCREEN_WIDTH-30, 30);
    button.backgroundColor = COLOR(222, 35, 46, 1);
    [button setTitle:@"提交反馈" forState:UIControlStateNormal];
    
    [view addSubview:button];
    
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH-20, 20)];
    label.text = @"欢迎提需求或建议，我们的进步离不开您的反馈！";
    label.textColor = [UIColor blackColor];
    
    return label;
}


@end
