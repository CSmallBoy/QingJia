
//
//  HCTagManagerDetailViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//已激活标签详情

#import "HCTagManagerDetailViewController.h"
#import "HCTagManagerInfo.h"

#import "HCTagDetailHeaderView.h"
#import "HCTagDetailTableViewCell.h"

#import "HCHeathViewController.h"
#import "HCeditingViewController.h"
#import "HCTagClosedDetailViewControllwe.h"
#define TagManagerDetailCell @"TagManagerDetailCell"

@interface HCTagManagerDetailViewController (){
    BOOL ool;
    UIButton *button;
    UIButton *button2;
    UIView *view_all;
    UIImageView *button_view;
}

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) HCTagManagerInfo *info;

@end

@implementation HCTagManagerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    _info = self.data[@"data"];
    self.tableView.tableHeaderView = self.headerView;
    self.title = @"标签详情";
    [self.tableView registerClass:[HCTagDetailTableViewCell class] forCellReuseIdentifier:TagManagerDetailCell];
    UIBarButtonItem *add_bar_button = [[UIBarButtonItem alloc]initWithImage:IMG(@"导航条－inclass_Plus") style:UIBarButtonItemStylePlain target:self action:@selector(add_click)];
//    UIBarButtonItem *add_bar_button = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone  target:self action:@selector(add_click)];
    ool = YES;
    self.navigationItem.rightBarButtonItem = add_bar_button;
    
}
-(void)add_click{
    NSLog(@"%d",ool);
    if (ool) {
        button_view.hidden = NO;
       
    }else{
            //[button removeFromSuperview];
         button_view.hidden = YES;
    }
    ool =!ool;
    
    
}
#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TagManagerDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = self.info;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark--UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        HCHeathViewController *heathVc = [[HCHeathViewController alloc]init];
        [self.navigationController pushViewController:heathVc animated:YES];
    }
}
#pragma mark --Setter Or Getter

-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,210)];
        _headerView.backgroundColor = [UIColor whiteColor];
//
//        HCTagDetailHeaderView *view1 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
//        
//        view1.tagIMGView.image = OrigIMG(_info.imgArr[_index]);
//        view1.tagNameLab.text = _info.tagNameArr[_index] ;
//        view1.tagIDLab.text = _info.tagIDArr[_index] ;
//        view1.tagIMGView.frame = CGRectMake(0, 0,SCREEN_WIDTH, 100);
//        view1.tagNameLab.frame = CGRectMake(120, 10, SCREEN_WIDTH-130, 60);
//        view1.tagIDLab.frame = CGRectMake(120, 70, SCREEN_WIDTH-130, 40);
        UIImageView *image_head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        image_head.image = OrigIMG(_info.imgArr[_index]);
         [self.headerView addSubview:image_head];
        
        UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 140, 110, 20)];
        idLabel.text = @"ID:123456789";
        idLabel.adjustsFontSizeToFitWidth = YES;
        idLabel.textColor = [UIColor blackColor];
        [self.headerView addSubview:idLabel];
       //[self.view addSubview:image_head];
        //[self.headerView addSubview:view1];
       
        
//        HCTagDetailHeaderView *view2 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH/2, 100)];
//        
//        view2.tagIMGView.image = OrigIMG(_info.contactImgArr[0]);
//        view2.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[0]];
//        view2.tagNameLab.numberOfLines = 0;
//        view2.tagIDLab.text = [NSString stringWithFormat:@"电话：\n%@",_info.contactPhoneArr[0]];
//        view2.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
//        view2.tagNameLab.frame = CGRectMake(75, 0, view2.bounds.size.width-75, 50);
//        view2.tagNameLab.font = [UIFont systemFontOfSize:14];
//        view2.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
//        view2.tagIDLab.font = [UIFont systemFontOfSize:12];
//        view2.tagIDLab.numberOfLines = 0;
        NSArray *arr =@[@"父亲(紧急联系人)",@"母亲(紧急联系人)"];
        UIView *view2 = [[UIView  alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
        view2.backgroundColor = kHCBackgroundColor;
        for (int i = 0 ; i < 2; i ++) {
            UIImageView *image_phone = [[UIImageView alloc]initWithFrame:CGRectMake(100 + i * 130, 15, 20, 20)];//父亲电话图标
            image_phone.image = [UIImage imageNamed:@"PHONE-2"];
            UILabel *phone_num = [[UILabel alloc]initWithFrame:CGRectMake(130 + i * 130, 12, 100, 30)];
            phone_num.font = [UIFont systemFontOfSize:13];
            phone_num.text = arr[i];
            [view2 addSubview:image_phone];
            [view2 addSubview:phone_num];
        }
        
        
        [self.headerView addSubview:view2];
        
//        if (_info.contactImgArr.count  != 1 )
//        {
//            HCTagDetailHeaderView *view3 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 110, SCREEN_WIDTH/2, 100)];
//            view3.tagIMGView.image = OrigIMG(_info.contactImgArr[1]);
//            view3.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[1]];
//            view3.tagNameLab.numberOfLines = 0;
//            view3.tagIDLab.text = [NSString stringWithFormat:@"电话：\n%@",_info.contactPhoneArr[1]];
//            view3.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
//            view3.tagNameLab.frame = CGRectMake(75, 0, view2.bounds.size.width-75, 50);
//            view3.tagNameLab.font = [UIFont systemFontOfSize:14];
//            view3.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
//            view3.tagIDLab.font = [UIFont systemFontOfSize:12];
//            view3.tagIDLab.numberOfLines = 0;
//            [self.headerView addSubview:view3];
//        }
    }
    UIButton *header_button = [UIButton buttonWithType:UIButtonTypeCustom];
    header_button.frame = CGRectMake(10, 130, 70, 70);
    header_button.layer.masksToBounds = YES;
    header_button.layer.cornerRadius = 35;
    [header_button setImage:[UIImage imageNamed:@"image_hea.jpg"] forState:UIControlStateNormal];
    [_headerView addSubview:header_button];
    
    //添加的button
    button_view= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 90, 63)];
    button_view.userInteractionEnabled = YES;
    button_view.image = [UIImage imageNamed:@"group"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2, 90, 30);
    [button setTitle:@"编辑标签" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setBackgroundColor:[UIColor clearColor]];
    
    [button addTarget:self action:@selector(editingClick) forControlEvents:UIControlEventTouchUpInside];
   
    [button_view addSubview:button];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0,33, 90, 30);
    [button2 setBackgroundColor:[UIColor clearColor]];
    [button2 setTitle:@"停用标签" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    [button2 addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
     button_view.hidden= YES;
    [button_view addSubview:button2];
    [_headerView addSubview:button_view];
    
    return _headerView;
}
//编辑标签
-(void)editingClick{
    HCeditingViewController *vc = [[HCeditingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)stopClick{
    NSArray *arr = @[@"停用",@"取消"];
    view_all = [[UIView alloc]initWithFrame:self.view.bounds];
    view_all.backgroundColor  = [UIColor grayColor];
    view_all.alpha = 0.97;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2,SCREEN_HEIGHT*0.33, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.3)];
    view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0 ; i < 2; i ++) {
        UIButton *label_button = [UIButton buttonWithType:UIButtonTypeCustom];
        label_button.frame = CGRectMake(10,SCREEN_HEIGHT*0.32*0.5+35*i , SCREEN_WIDTH*0.6-20, 28);
        label_button.tag = 1000+i;
        [label_button setTitle:arr[i] forState:UIControlStateNormal];
        [label_button addTarget:self action:@selector(label_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [label_button setBackgroundColor:[UIColor redColor]];
        }else{
            [label_button setBackgroundColor:[UIColor blueColor]];
        }
        [view addSubview:label_button];
    }
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(view.bounds.size.width*0.1, 15, view.bounds.size.width*0.8, 50)];
    alert_label.text = @"确认是否永久停用该标签!";
    alert_label.numberOfLines = 0;
    [view addSubview:alert_label];
    ViewBorderRadius(view, 10, 0, CLEARCOLOR);
    [view_all addSubview:view];
    [self.view addSubview:view_all];
    
}
-(void)label_buttonClick:(UIButton*)buttton{
    switch (buttton.tag) {
        case 1000:
        {
            HCTagClosedDetailViewControllwe *Vc = [[HCTagClosedDetailViewControllwe alloc]init];
            [self.navigationController pushViewController:Vc animated:YES];
        }
            break;
        case 1001:
        {
            [view_all removeFromSuperview];
        }
            break;
        default:
            break;
    }
    
}
@end
