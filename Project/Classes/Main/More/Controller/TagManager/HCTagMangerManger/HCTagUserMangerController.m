//
//  HCTagUserMangerController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserMangerController.h"
#import "HCNewTagInfo.h"


@interface HCTagUserMangerController ()

@end

@implementation HCTagUserMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用者管理";
    [self setupBackItem ];
    
    [self requestData];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"导航条－inclass_Plus") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"userMangerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
    HCNewTagInfo *info = self.dataSource[indexPath.row];
    cell.textLabel.text = info.trueName;
    
    return cell;
    
}

#pragma mark --- provite moehods

//点击了加号按钮

-(void)rightItemClick:(UIBarButtonItem *)item
{
  
}


#pragma mark --- Network

-(void)requestData
{
    for (int i = 0; i<6; i++) {
       
        HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
        info.trueName = [NSString stringWithFormat:@"小孩%d",i];
        info.imageName = @"11111";
        info.sex  = @"女";
        info.birthDay = @"2000-12-11";
        info.homeAddress = @"上海市闵行区集心路168号";
        info.school = @"汪家小学";
        info.height = @"130";
        info.weight = @"40";
        info.bloodType = @"A";
        info.allergic = @"没有过敏历史";
        info.cureCondition = @"良好";
        info.cureNote = @"没有医疗笔记";
        
        [self.dataSource addObject:info];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
