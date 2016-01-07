//
//  HCReturnAuditNotPassViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReturnAuditNotPassViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

#import "HCEditCommentViewController.h"

#import "HCCustomerInfo.h"

@interface HCReturnAuditNotPassViewController ()<HCShowReasonTableViewCellDelegate>

@property (nonatomic,strong) HCCustomerInfo *info;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,assign) CGFloat cellHight;

@end

@implementation HCReturnAuditNotPassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"审核不通过";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(1.0);
    _info = self.data[@"data"];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0)
    {
        static NSString *RecordID = @"waitAuditOrder";
        HCCustomerTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:RecordID];
        orderCell = [[HCCustomerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        orderCell.info = self.info;
        orderCell.indexPath = indexPath;
        cell = orderCell;
    }
    else if(indexPath.section== 1)
    {
        if (indexPath.row == 0)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reissueReason"];
            cell.textLabel.text = @"补发原因";
            cell.detailTextLabel.text = [HCDictionaryMgr applyReissueReason:self.info.reason];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 1)
        {
            HCShowReasonTableViewCell *showCell = [[HCShowReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"show"];
            showCell.delegate = self;
            showCell.info = self.info;
            cell = showCell;
        }
        else if (indexPath.row == 2)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reissueNotPassReason"];
            UILabel *label = [[UILabel alloc]init];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:15];
            
            CGRect cellFrame = [cell frame];
            cellFrame.origin = CGPointMake(0, 0);
            
            label.text = [NSString stringWithFormat:@"M-Talk回复: %@",_info.auditNotPassReason];
            CGRect rect = CGRectInset(cellFrame, 2, 2);
            label.frame = rect;
            [label sizeToFit];
            if (label.frame.size.height > 46)
            {
                cellFrame.size.height = 50 + label.frame.size.height - 46;
            }
            else {
                cellFrame.size.height = 50;
            }
            [cell setFrame:cellFrame];
            [cell.contentView addSubview:label];
            
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
    
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        return 200;
    }
    else if (indexPath.section == 1&&indexPath.row == 1)
    {
        return _cellHight;
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  (section == 0) ? 5 : 120 ;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == 0) ? nil : self.footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


#pragma mark---HCShowReasonTableViewCellDelegate

-(void)passcellHight:(CGFloat)cellheight
{
    _cellHight = cellheight;
}

#pragma mark--private method

-(void)clickReviewBtn
{
    HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
    UIViewController *rootController = self.view.window.rootViewController;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        editComment.modalPresentationStyle=
        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    }else
    {
        rootController.modalPresentationStyle=
        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    }
    [rootController presentViewController:editComment animated:YES completion:nil];
}

#pragma mark-----Setter Or Getter

-(UIView *)footView
{
    if (!_footView)
    {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        UIButton *reviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reviewBtn.frame = CGRectMake(20, 40, SCREEN_WIDTH-40, 40);
        [reviewBtn setTitle:@"回复申请补货" forState:UIControlStateNormal];
        [reviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        reviewBtn.backgroundColor = [UIColor redColor];
        ViewRadius(reviewBtn, 2);
        [reviewBtn addTarget:self action:@selector(clickReviewBtn) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:reviewBtn];
    }
    return _footView;
}

@end
