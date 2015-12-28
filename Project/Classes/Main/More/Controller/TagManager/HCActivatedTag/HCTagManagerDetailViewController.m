
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

#define TagManagerDetailCell @"TagManagerDetailCell"

@interface HCTagManagerDetailViewController ()

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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark --Setter Or Getter

-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,210)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        HCTagDetailHeaderView *view1 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        
        view1.tagIMGView.image = OrigIMG(_info.imgArr[_index]);
        
   
        
        view1.tagNameLab.text = _info.tagNameArr[_index] ;
        
        view1.tagIDLab.text = _info.tagIDArr[_index] ;
        
        view1.tagIMGView.frame = CGRectMake(10, 10, 100, 100);
        view1.tagNameLab.frame = CGRectMake(120, 10, SCREEN_WIDTH-130, 60);
        view1.tagIDLab.frame = CGRectMake(120, 70, SCREEN_WIDTH-130, 40);
        
        [self.headerView addSubview:view1];
        
        HCTagDetailHeaderView *view2 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH/2, 100)];
        
        view2.tagIMGView.image = OrigIMG(_info.contactImgArr[0]);
        view2.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[0]];
        view2.tagNameLab.numberOfLines = 0;
        view2.tagIDLab.text = [NSString stringWithFormat:@"电话：%@",_info.contactPhoneArr[0]];
        view2.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
        view2.tagNameLab.frame = CGRectMake(75, 0, view2.bounds.size.width-75, 50);
        view2.tagNameLab.font = [UIFont systemFontOfSize:14];
        view2.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
        view2.tagIDLab.font = [UIFont systemFontOfSize:12];
        view2.tagIDLab.numberOfLines = 0;
        [self.headerView addSubview:view2];
        
        if (_info.contactImgArr.count  != 1 )
        {
            HCTagDetailHeaderView *view3 = [[HCTagDetailHeaderView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 110, SCREEN_WIDTH/2, 100)];
            view3.tagIMGView.image = OrigIMG(_info.contactImgArr[1]);
            view3.tagNameLab.text = [NSString stringWithFormat:@"%@(紧急联系人)",_info.contactNameArr[1]];
            view3.tagNameLab.numberOfLines = 0;
            view3.tagIDLab.text = [NSString stringWithFormat:@"电话：%@",_info.contactPhoneArr[1]];
            view3.tagIMGView.frame = CGRectMake(10, 10, 60, 60);
            view3.tagNameLab.frame = CGRectMake(75, 10, view2.bounds.size.width-75, 50);
            view3.tagNameLab.font = [UIFont systemFontOfSize:14];
            view3.tagIDLab.frame = CGRectMake(75, 50, view2.bounds.size.width-75, 50);
            view3.tagIDLab.font = [UIFont systemFontOfSize:12];
            view3.tagIDLab.numberOfLines = 0;
            [self.headerView addSubview:view3];
            
        }
        
    }
    return _headerView;
}



@end
