//
//  HCUserHeathViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCUserHeathViewController.h"
#import "NHCUserHeathApi.h"
#import "NHCGetUserHeathApi.h"
#import "HCUserMessageViewController.h"
@interface HCUserHeathViewController ()<UITextFieldDelegate>{
    NSString *heigh;
    NSString *weight;
    NSString *Blood;
    NSString *allergy;
    NSString *condition;
    NSString *note;
    NSArray *arr;
    
}

@end

@implementation HCUserHeathViewController
- (void)viewWillAppear:(BOOL)animated{
//    //先从服务器获取数据  如果没有在执行另一套方案
//    NHCGetUserHeathApi *API= [[NHCGetUserHeathApi alloc]init];
//    [API startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
//        if (requestStatus == HCRequestStatusSuccess) {
//            arr = responseObject;
//            [self.tableView reloadData];
//        }
//    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"医疗急救卡";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    self.navigationItem.rightBarButtonItem = bar;
    [self getData];
}
//保存身高体重
- (void)saveClick{
    NHCUserHeathApi *api = [[NHCUserHeathApi alloc]init];
    api.height = heigh;
    api.weight = weight;
    api.bloodType = Blood;
    api.allergic = allergy;
    api.cureCondition = condition;
    api.cureNote = note;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        
    }];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[HCUserMessageViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr2 = @[@"身高",@"体重",@"血型",@"过敏史",
                     @"医疗状况",@"医疗笔记"];
    //NSArray *arr_detil =@[@"请输入身高",@"请输入体重",@"请输入血型",@"过敏史",@"医疗状况",@"医疗笔记"];
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
      UITextField *label2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 5, 150, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 40)];
    label2.delegate = self;

    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        label.text = arr2[indexPath.row];
        
        if ([_arr_heath[0] isEqualToString:@"请输入身高"]) {
            label2.placeholder = _arr_heath[indexPath.row];
        }else{
            label2.text = _arr_heath[indexPath.row];
        }
        
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
            heigh = textField.text;
            break;
        case 1:
            weight = textField.text;
            break;
        case 2:
            Blood = textField.text;
            break;
        case 3:
            allergy = textField.text;
            break;
        case 4:
            condition = textField.text;
            break;
        case 5:
            note = textField.text;
            break;
            
        default:
            break;
    }
}
-(void)getData{
 
    
    
}

@end
