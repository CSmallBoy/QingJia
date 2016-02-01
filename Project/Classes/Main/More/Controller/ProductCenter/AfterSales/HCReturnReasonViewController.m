//
//  HCReturnReasonViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCReturnReasonViewController.h"
#import "HCApplyReturnResonInfo.h"


#define ReissueReasoncell @"HCReissueReasonCell"
@interface HCReturnReasonViewController ()

@property (nonatomic, assign) NSInteger selected;
@property (nonatomic,strong) HCApplyReturnResonInfo *info;
@end

@implementation HCReturnReasonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"退货原因";
    [self setupBackItem];
    _info = self.data[@"data"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReissueReasoncell];
    
    cell.textLabel.text = [HCDictionaryMgr applyReturnReason:[NSString stringWithFormat:@"%@",@(indexPath.row)]];
    if ([_info.reason integerValue] == indexPath.row)
    {
        cell.imageView.image = OrigIMG(@"select");
    }else
    {
        cell.imageView.image = OrigIMG(@"left_white");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _info.reason = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}




@end
