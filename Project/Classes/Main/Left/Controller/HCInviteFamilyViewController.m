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
@interface HCInviteFamilyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HCInviteFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请家庭加入";
    self.view.backgroundColor = kHCBackgroundColor;
    [self setupBackItem];
    [self makeUI];
}
//界面创建
- (void)makeUI{
    //搜索
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    UITextField *text_tf = [[UITextField alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH*0.7, 30)];
    text_tf.placeholder = @"请输入您要搜索的家庭ID";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(5+SCREEN_WIDTH*0.7, 7, SCREEN_WIDTH*0.3-10, 30)];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [view addSubview:text_tf];
    [self.view addSubview:view];
    //tabview 重写tabview
    UITableView*tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tabview.delegate = self;
    tabview.dataSource = self;
    [self.view addSubview:tabview];
    
    
    
}
- (void)buttonClick{
    NSLog(@"搜索");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
