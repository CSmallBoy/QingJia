//
//  HCRefundSuccessViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//退款成功

#import "HCRefundSuccessViewController.h"

@interface HCRefundSuccessViewController ()

@end

@implementation HCRefundSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //退款成功
    self.title = @"退货/售后";
}

#pragma mark----UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID =@"Refund success";
    UITableViewCell *RefundSuccesscell ;
    RefundSuccesscell = [ tableView dequeueReusableCellWithIdentifier:CellID];
    RefundSuccesscell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    
    return RefundSuccesscell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 2;
    }else if (section == 2)
    {
        return 3;
    }else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 200;
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            return 150;
        } else
        {
            return 44;
        }
    }
    else
    {
        return 44;
    }
}



@end

