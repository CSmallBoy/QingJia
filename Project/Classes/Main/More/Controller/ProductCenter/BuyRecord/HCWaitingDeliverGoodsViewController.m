//
//  HCWaitingDeliverGoodsViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCWaitingDeliverGoodsViewController.h"
#import "HCBuyRecordTableViewCell.h"
#import "HCProductIntroductionInfo.h"

@interface HCWaitingDeliverGoodsViewController ()

@property (nonatomic,strong) HCProductIntroductionInfo *info;

@end

@implementation HCWaitingDeliverGoodsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"待发货";
    _info = self.data[@"data"];
}

#pragma mark --- UITableViewDelegatee

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *waitingID = @"waitingDeliverGood";
    HCBuyRecordTableViewCell *waitingCell = [tableView dequeueReusableCellWithIdentifier:waitingID];
        waitingCell = [[HCBuyRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitingID];

    waitingCell.info = _info;
    waitingCell.indexPath= indexPath;

    return waitingCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 44;
    }else if (indexPath.row == 1)
    {
        return 88;
    }else
    {
        return 100;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

@end
