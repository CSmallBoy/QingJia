//
//  HCReissueReasonViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCReissueReasonViewController.h"

#import "HCApplyReissueResonInfo.h"


#define ReissueReasoncell @"HCReissueReasonCell"
@interface HCReissueReasonViewController ()

@property (nonatomic, assign) NSInteger selected;
@property (nonatomic, strong) HCApplyReissueResonInfo *info;

@end

@implementation HCReissueReasonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"补发原因";
    [self setupBackItem];
    _info = self.data[@"data"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReissueReasoncell];
    cell.textLabel.text = [HCDictionaryMgr applyReissueReason:[NSString stringWithFormat:@"%@",@(indexPath.row)]];
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
    [tableView reloadData];
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
