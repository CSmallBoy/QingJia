//
//  HCTagUserDetailController.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserDetailController.h"
#import "HCNewTagInfo.h"

@interface HCTagUserDetailController ()

@property (nonatomic,strong) NSString *myTitle;
@property (nonatomic,strong) HCNewTagInfo *info;

@end

@implementation HCTagUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = self.data[@"title"];
    self.info = self.data[@"info"];
    
    self.title = [NSString stringWithFormat:@"%@的信息",self.myTitle];
    [self setupBackItem];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 6;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
