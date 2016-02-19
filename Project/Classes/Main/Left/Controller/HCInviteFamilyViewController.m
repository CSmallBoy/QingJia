//
//  HCInviteFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCInviteFamilyViewController.h"
#import "HCinviteFamilyTableViewCell.h"
//幸福家庭
#import "HCWealFamilyViewController.h"
@interface HCInviteFamilyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITextField *_text_tf;
    //搜索结果
    NSMutableArray *_result;
    NSArray *arr;
    UITableView*tabview;
    BOOL sousuo;
    UIButton *button;
}

@end

@implementation HCInviteFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请家庭加入";
    self.view.backgroundColor = kHCBackgroundColor;
    _result = [NSMutableArray array];
    [self setupBackItem];
    [self makeUI];
    sousuo = YES;
}
//界面创建
- (void)makeUI{
    //搜索
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    _text_tf = [[UITextField alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH*0.7, 30)];
    _text_tf.delegate = self;
    _text_tf.placeholder = @"请输入您要搜索的家庭ID";
    _text_tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(5+SCREEN_WIDTH*0.7, 7, SCREEN_WIDTH*0.3-10, 30)];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [view addSubview:_text_tf];
    [self.view addSubview:view];
    //tabview 重写tabview
    tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tabview.delegate = self;
    tabview.dataSource = self;
    [self.view addSubview:tabview];
    arr = @[@"1",@"2",@"3",@"4"];
    _result = [NSMutableArray arrayWithArray:arr];
    
    
}
//搜索事件
- (void)buttonClick{
    
    //先判断  是否输入
    if ([_text_tf.text isEqualToString:@""]) {
        //给与提示
    }else{
        [_result removeAllObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains %@",_text_tf.text];
        NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
        //model 是数据 arr是所有数据 最后  还要用model
        for (NSString *str in arr) {
            [nameArr addObject:str];
        }
        NSArray *resultArr = [nameArr filteredArrayUsingPredicate:predicate];
        //model 是 数据
        for (NSString *str2 in arr)
        {
            
            for (NSString *name in resultArr)
            {
                if ([name isEqualToString:str2])
                {
                    [_result addObject:name];
                }
                
            }
        }
        if (sousuo) {
            [button setTitle:@"搜索" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }
        //搜索结束后 刷新tabview  换数据
        [tabview reloadData];
        sousuo = !sousuo;
    }
    

}
#pragma mark textFiled代理方法
//暂时没用  结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [tabview reloadData];
    
}
//准备编辑是触发
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [tabview reloadData];
}
#pragma mark tabview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_text_tf.text isEqualToString:@""]) {
        return 10;
        //原来的内容
    }else{
        return _result.count;
        //搜索返回的内容
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT*0.084;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    HCinviteFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[HCinviteFamilyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.label_head.text = [NSString stringWithFormat:@"家庭%ld",indexPath.row];
    [cell.button_invite setTitle:@"邀请" forState:UIControlStateNormal];
    cell.image_head.image = [UIImage imageNamed:@"image_hea.jpg"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"邀请通讯录好友创建的家庭";
    }else{
        return @"";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HCWealFamilyViewController *VC = [[HCWealFamilyViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end
