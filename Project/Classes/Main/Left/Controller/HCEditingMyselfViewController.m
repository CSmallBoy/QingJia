//
//  HCEditingMyselfViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditingMyselfViewController.h"

@interface HCEditingMyselfViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tabView;
@end

@implementation HCEditingMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人事迹";
    [self makeUI];
}
-(void)makeUI{
    //添加  编辑按钮
    UIBarButtonItem *bar_button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editingClick)];
    self.navigationItem.rightBarButtonItem = bar_button;
    //添加图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.26)];
    //头像显示
    UIImageView *head_image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.346, 20, SCREEN_HEIGHT*0.16, SCREEN_HEIGHT*0.16)];
    head_image.layer.masksToBounds = YES;
    head_image.layer.cornerRadius = SCREEN_HEIGHT*0.08;
    [image addSubview:head_image];
    //tabview
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tabView.delegate = self;
    _tabView.dataSource =self;
    _tabView.tableHeaderView = image;
    
}
//编辑  事件 跳转
-(void)editingClick{
    
}
#pragma mark tabview 代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
