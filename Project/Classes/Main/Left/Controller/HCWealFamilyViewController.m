//
//  HCWealFamilyViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCWealFamilyViewController.h"
#import "ButtonView.h"
@interface HCWealFamilyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arr;
    NSArray *arr2;
    //UITableView *tabView ;
    NSString *str;
    UIView *view2;
    UIView *view1;
}

@end

@implementation HCWealFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"幸福家庭";
    arr = @[@"名片",@"祖籍",@"住址"];
    arr2 = @[@"家庭二维码",@"上海",@"住上海闵行区168号"];
    self.view.backgroundColor = [UIColor colorWithRed:234 green:234 blue:234 alpha:1];
    [self setupBackItem];
    
    [self makeUI2];
}
- (void)makeUI2{
    //头
    UIImageView *image_head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT*0.2623)];
    image_head.image = [UIImage imageNamed:@"head.jpg"];
   self.tableView.tableHeaderView = image_head;
    //头像上的字
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5,  SCREEN_HEIGHT*0.22, SCREEN_WIDTH-10, 20)];
    label.text = @"我们的班级签名";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = CLEARCOLOR;
    [image_head addSubview:label];
    //[self.view addSubview:tabView];
    //尾部
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确认邀请" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, SCREEN_HEIGHT-50, SCREEN_WIDTH-40, 30)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(surebutton) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:button];
    
    
    
}
- (void)surebutton{
    //蒙层视图层
    view1 = [[UIView alloc]initWithFrame:self.view.frame];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.4;
    [self.view addSubview:view1];
    
    //弹框视图层
    view2= [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.4, SCREEN_WIDTH*0.60, SCREEN_HEIGHT*0.2)];
    view2.backgroundColor = [UIColor whiteColor];
    ViewBorderRadius(view2, 10, 0, CLEARCOLOR);
    [self.view addSubview:view2];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH*0.60*0.88, 7, 20, 20);
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
   UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.09, SCREEN_WIDTH*0.6, 30)];
    label.text = @"邀请已发送...";
    label.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label];
    [view2 addSubview:button];
}
//移除view2
-(void)buttonClick{
    [view2 removeFromSuperview];
    [view1 removeFromSuperview];
}
#pragma mark tabview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else{
        return 2;
    }
}
//分为两组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    if (indexPath.section==0) {
        UILabel *name_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 40, 30)];
        name_label.text = arr[indexPath.row];
        UILabel *detail_label = [[UILabel alloc]initWithFrame:CGRectMake(10+50, 7, SCREEN_WIDTH - 60, 30)];
        detail_label.text = arr2[indexPath.row];
        [cell addSubview:detail_label];
        [cell addSubview:name_label];
        if (indexPath.row==0) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.85, 3, SCREEN_WIDTH*0.15-10, 39)];
            image.image = [UIImage imageNamed:@"head.jpg"];
            [cell addSubview:image];
        }
    }else {
        if (indexPath.row==0) {
            UILabel *title_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
            title_label.text = str;
            [cell addSubview:title_label];
        }else{
            for (int i = 0; i < 5; i ++) {
                ButtonView *button = [[ButtonView alloc]initWithFrame:CGRectMake(10+(SCREEN_WIDTH/5)*i, 10, (SCREEN_WIDTH-160-40)/5, (SCREEN_WIDTH-160-40)/5)];
                [cell addSubview:button];
            }
            
        }
    }
    return cell;
}
//头高15个像素
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 44;
        }else{
            //先写死  回头再改
            return 100;
        }
    }else{
        return 44;
    }
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
