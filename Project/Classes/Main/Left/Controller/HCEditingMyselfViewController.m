//
//  HCEditingMyselfViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditingMyselfViewController.h"
#import "HCsaveEditingViewController.h"
@interface HCEditingMyselfViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tabView;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *arr2;
@end

@implementation HCEditingMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人事迹";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    [self makeUI];
    _arr = @[@"姓名",@"辈分",@"年龄",@"生日",@"住址"];
    _arr2 = @[@"张三丰",@"爷爷",@"121",@"1403",@"上海闵行区集心路"];
}
-(void)makeUI{
    //添加  编辑按钮
    UIBarButtonItem *bar_button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editingClick)];
    self.navigationItem.rightBarButtonItem = bar_button;
  
    
    //添加图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.26)];
    image.image = [UIImage imageNamed:@"image.jpg"];
    //添加昵称label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.346, 20+SCREEN_HEIGHT*0.16+10, SCREEN_HEIGHT*0.16,20)];
    label.text = @"名字昵称";
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.8;
    [image addSubview:label];
    //头像显示
    UIImageView *head_image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.346, 20, SCREEN_HEIGHT*0.16, SCREEN_HEIGHT*0.16)];
    [image addSubview:head_image];
    head_image.image = [UIImage imageNamed:@"image_hea.jpg"];
    ViewBorderRadius(head_image, SCREEN_HEIGHT*0.08, 1, [UIColor redColor]);
    //tabview
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tabView.delegate = self;
    _tabView.dataSource =self;
    _tabView.tableHeaderView = image;
    [self.view addSubview:_tabView];
    
    
}
//编辑  事件 跳转
-(void)editingClick{
    HCsaveEditingViewController *Vc = [[HCsaveEditingViewController alloc]init];
    [self.navigationController pushViewController:Vc animated:YES];
    
}
#pragma mark tabview 代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    for (UILabel *label2 in cell.subviews) {
        [label2 removeFromSuperview];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 40, 39)];
    [cell addSubview:label];
    label.text = _arr[indexPath.row];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(45, 3, SCREEN_WIDTH - 45 -5, 39)];
    [cell addSubview:label3];
    label3.text = _arr2[indexPath.row];
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
