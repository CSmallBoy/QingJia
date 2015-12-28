//
//  HCApplyReissueViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReissueViewController.h"
#import "HCProductIntroductionInfo.h"

#import "HCApplyReissueOrderCell.h"

@interface HCApplyReissueViewController ()

@property (nonatomic,strong)HCProductIntroductionInfo *productInfo;


@end

@implementation HCApplyReissueViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"申请补发";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    _productInfo = self.data[@"data"];
    [self.tableView reloadData];
    
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (cell == nil) {
        if (indexPath.section == 0) {
            HCApplyReissueOrderCell *applyReissueOrderCell = [tableView dequeueReusableCellWithIdentifier:@"orderInfo"];
            applyReissueOrderCell = [[HCApplyReissueOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderInfo"];
            
            applyReissueOrderCell.info = _productInfo;
            cell = applyReissueOrderCell;
            
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"22"];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"22"];
            cell.textLabel.text = self.productInfo.orderID;
        }
    }
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 200;
    }
    else{
        return 50;
    }
}

@end
