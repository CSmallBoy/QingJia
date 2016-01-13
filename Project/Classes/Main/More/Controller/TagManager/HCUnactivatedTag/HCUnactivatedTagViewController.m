//
//  HCUnactivatedTagViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUnactivatedTagViewController.h"
#import "HCTagManagerInfo.h"
#import "HCUnactivatedTagApi.h"
#import "HCTagManagerTableViewCell.h"

#import "lhScanQCodeViewController.h"
#import "HCActivateTagApi.h"

#define UnactivatedTagcell @"UnactivatedTagcell"

@interface HCUnactivatedTagViewController()<HCTagManagerTableViewCellDelegate>

@property (nonatomic, strong) NSArray *TagArr;
@property (nonatomic, strong) NSArray *vClassNameArr;
@property (nonatomic,strong) HCTagManagerInfo *info;

@end
@implementation HCUnactivatedTagViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestHomeData];
    [self.tableView registerClass:[HCTagManagerTableViewCell class] forCellReuseIdentifier:UnactivatedTagcell];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UnactivatedTagcell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    HCTagManagerInfo *info = _info;
    cell.info = info;
    cell.indexPath = indexPath;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH - 60)/3 +50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _info.imgArr.count % 3;
    NSInteger row = (count) ? 1 : 0;
    return ((int)_info.imgArr.count/3) + row;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark---HCTagManagerTableViewCellDelegate

-(void)HCTagManagerTableViewCell:(NSIndexPath *)indexPath tag:(NSInteger)tag
{
    NSInteger index = tag+indexPath.row*3;
//    [self showHUDText:_info.tagNameArr[index]];
    [self showOkayCancelAlert];
   
}

#pragma mark - private methods

- (void)showOkayCancelAlert {
    NSString *title = @"确认要扫描二维码激活吗？";
    NSString *message = nil;
    NSString *cancelButtonTitle = NSLocalizedString(@"否", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"是", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        lhScanQCodeViewController *scanVC = [[lhScanQCodeViewController alloc]init];
//        [self.navigationController pushViewController:scanVC animated:YES];
                [self requestActivateTag];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - network

-(void)requestActivateTag
{
    HCActivateTagApi *api = [[HCActivateTagApi alloc]init];
    api.LabelGUID = @"d52fb7c5-462d-458d-94bd-35904889a95d";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data)
     {
         if (requestStatus == HCRequestStatusSuccess)
         {
             [self.tableView reloadData];
         }else
         {
             [self showHUDError:message];
         }
     }];
}

- (void)requestHomeData
{
    HCUnactivatedTagApi *api = [[HCUnactivatedTagApi alloc] init];
    api.Start = 1000;
    api.Count = 20;
    api.LabelStatus = @"未激活";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCTagManagerInfo *info) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            _info = info;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
