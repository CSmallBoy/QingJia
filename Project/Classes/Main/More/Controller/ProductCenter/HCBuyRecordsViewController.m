//
//  HCBuyRecordsViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCBuyRecordsViewController.h"

@interface HCBuyRecordsViewController ()

@end

@implementation HCBuyRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买记录";
    [self setupBackItem];
    
}

#pragma mark--Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordID = @"record";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
    }
    cell.textLabel.text = @"1";
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
