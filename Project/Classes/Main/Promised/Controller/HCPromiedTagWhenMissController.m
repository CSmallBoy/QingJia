//
//  HCPromisedTagMangerViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//


#import "HCPromiedTagWhenMissController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCPromisedMissMessageControll.h"

#import "HCPromisedTagCell.h"
#import "HCTagAmostDetailListApi.h"
#import "HCNewTagInfo.h"

#import "HCMissTagTableViewCell.h"

@interface HCPromiedTagWhenMissController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tagTableView;//标签列表

@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCPromiedTagWhenMissController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"走失时候佩戴的标签";
    [self requestData];
    [self setupBackItem];
    [self.view addSubview:self.tagTableView];
    [self.view addSubview:self.footerView];
}

#pragma mark - tableView Delegate/Datesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMissTagTableViewCell *cell = [HCMissTagTableViewCell customCellWithTable:tableView];
//    HCNewTagInfo *info = self.dataArr[indexPath.row];
//    [cell.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    NSURL *url = [readUserInfo originUrl:info.imageName :kkLabel];
//    [cell.clothingImage sd_setImageWithURL:url];
//    cell.titleLabel.text = info.labelTitle;
//    cell.idLabel.text = [NSString stringWithFormat:@"ID:%@", info.objectId];
//    cell.remarkLabel.text = [NSString stringWithFormat:@"备注:%@", info.labelTitle];
    cell.titleLabel.text = @"标题";
    cell.idLabel.text = @"ID";
    cell.remarkLabel.text = @"备注";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HCNewTagInfo *info = self.dataArr[indexPath.row];
//    HCMissTagTableViewCell *cell = [self.tagTableView cellForRowAtIndexPath:indexPath];
//    if (info.isBlack)
//    {
//        cell.selected = NO;
//        info.isBlack = NO;
//    }
//    else
//    {
//        cell.selected = YES;
//        info.isBlack = YES;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80/668.0*SCREEN_HEIGHT;
}

#pragma  mark --- private mothods

//点击选中按钮
- (void)selectedButtonAction:(UIButton *)sender
{
    //备注:isBlack按钮状态(YES为选中,NO为未选中)
    HCMissTagTableViewCell *cell = (HCMissTagTableViewCell*)sender.superview;
    NSIndexPath *index = [self.tagTableView indexPathForCell:cell];
    HCNewTagInfo *info = self.dataArr[index.row];
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        info.isBlack = YES;
    }
    else
    {
        info.isBlack = NO;
    }
}


// 点击了下一步按钮
-(void)toNextVC
{
    HCPromisedMissMessageControll*vc = [[HCPromisedMissMessageControll alloc]init];
    NSMutableArray *tagArr = [NSMutableArray array];
    
    for (HCNewTagInfo *info in self.dataArr)
    {
        if (info.isBlack)
        {
            [tagArr addObject:info];
        }
    }
    vc.info = self.info;
    vc.tagArr = tagArr;
    vc.contactArr = self.contactArr;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark --- getter Or setter

- (UITableView *)tagTableView
{
    if (_tagTableView == nil)
    {
        _tagTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50/668.0*SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tagTableView.delegate = self;
        _tagTableView.dataSource = self;
    }
    return _tagTableView;
}

-(NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:4];
    }
    return _dataArr;
}


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50/668.0*SCREEN_HEIGHT, SCREEN_WIDTH, 50/668.0*SCREEN_HEIGHT)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15/375.0*SCREEN_WIDTH, 0, SCREEN_WIDTH-30/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
        ViewRadius(button, 5);
        button.backgroundColor = kHCNavBarColor;
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toNextVC) forControlEvents:UIControlEventTouchUpInside ];
        [_footerView addSubview:button];
        
    }
    return _footerView;
}


#pragma mrk --- network

-(void)requestData
{
    HCTagAmostDetailListApi *api = [[HCTagAmostDetailListApi alloc]init];
    api.labelStatus = @"0";// 已经激活的标签
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone)
    {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSArray *array = respone[@"Data"][@"rows"];
            for (NSDictionary *dic in array)
            {
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
                [self.dataArr addObject:info];
            }
            [self.tagTableView reloadData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
