//
//  HCPromisedCommentController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedCommentController.h"

#import "HCPromisedCommentCell.h"

#import "HCPromisedCommentFrameInfo.h"
#import "HCPromisedCommentInfo.h"

@interface HCPromisedCommentController ()

@end

@implementation HCPromisedCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现线索";
    self.tableView.tableHeaderView = HCTabelHeadView(1);
    [self requestData];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor yellowColor];
    [self setupBackItem];
  
}

#pragma mark --- tableViewDelegate




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedCommentCell *cell = [HCPromisedCommentCell cellWithTableView:tableView];
    
    cell.commnetFrameInfo = self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedCommentFrameInfo *frameCell = self.dataSource[indexPath.row];
    return frameCell.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark ---  network

-(void)requestData
{
    
    for (int i= 0; i<20; i++) {
        
        HCPromisedCommentFrameInfo *commentFrameInfo = [[HCPromisedCommentFrameInfo alloc]init];
        HCPromisedCommentInfo *commentInfo = [[HCPromisedCommentInfo alloc]init];
      commentInfo.nickName  = [NSString stringWithFormat:@"用户昵称%d",i ];
       commentInfo.comment = @"我看到一个小孩子跟你描述的小孩子很像，在人民广场，你看看是不是你家小孩子";
        commentInfo.time = @"一分钟前";
        commentFrameInfo.commentInfo = commentInfo;
        [self.dataSource addObject:commentFrameInfo];
    }
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
