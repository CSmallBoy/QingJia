//
//  HCPublishViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPublishViewController.h"
#import "HCJurisdictionViewController.h"
#import "HCHomePublishApi.h"
#import "HCPublishTableViewCell.h"
#import "ACEExpandableTextCell.h"
#import "HCPublishInfo.h"

#define HCPublishCell @"HCPublishCell"

@interface HCPublishViewController ()<ACEExpandableTableViewDelegate, HCPublishTableViewCellDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HCJurisdictionVCDelegate>

@property (nonatomic, strong) HCPublishInfo *info;
@property (nonatomic, strong) UIBarButtonItem *publishBtnItem;
@property (nonatomic, assign) CGFloat editHeight;

@property (nonatomic, strong) NSMutableArray *uploadImageNameArr;

@end

@implementation HCPublishViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发布消息";
    [self setupBackItem];
    self.navigationItem.rightBarButtonItem = self.publishBtnItem;
    _info = [[HCPublishInfo alloc] init];
    _info.OpenAddress = @"1";
    _info.PermitType = @"100";
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HCPublishTableViewCell class] forCellReuseIdentifier:HCPublishCell];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        ACEExpandableTextCell *textCell = [tableView expandableTextCellWithId:@"editcell"];
        textCell.textView.placeholder = @"发表些心情吧...";
        textCell.textView.font = [UIFont systemFontOfSize:15];
        cell = textCell;
    }else
    {
        HCPublishTableViewCell *publishCell = [tableView dequeueReusableCellWithIdentifier:HCPublishCell];
        publishCell.delegate = self;
        publishCell.info = _info;
        publishCell.indexPath = indexPath;
        cell = publishCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
    {
        HCJurisdictionViewController *jurisdictionVC = [[HCJurisdictionViewController alloc] init];
        jurisdictionVC.delegate = self;
        [self.navigationController pushViewController:jurisdictionVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section) ? 1 : 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 46;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return MAX(80, _editHeight);
    }else if (indexPath.row == 1)
    {
        NSInteger rows = _info.FTImages.count / 3;
        rows += (_info.FTImages.count%3) ? 1 : 0;
        return (WIDTH(self.view)/3) *MIN(rows, 3);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - HCJurisdictionVCDelegate

- (void)hcJurisdictionViewControllerWithPermitType:(NSString *)PermitType permitUserArr:(NSMutableArray *)permitUserArr
{
    _info.PermitType = PermitType;
    _info.PermitUserArr = permitUserArr;
}

#pragma mark - HCPublishTableViewCellDelegate

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (_info.FTImages.count == index)
    {
       UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [action showInView:self.view];
    }
}

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index
{
    [_info.FTImages removeObjectAtIndex:index-1];
    [self.tableView reloadData];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) // 拍照
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (buttonIndex == 1) // 相册
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        //        [[picker navigationBar] setTintColor:[UIColor whiteColor]];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (_info.FTImages.count >= 10)
    {
        [self showHUDText:@"最多只能发布9张图片"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [_info.FTImages insertObject:image atIndex:_info.FTImages.count-1];
    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ACEExpandableTableViewDelegate

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _editHeight = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    _info.FTContent= text;
}

#pragma mark - private methods

- (void)handlePublishBarButtonItem
{
    if (IsEmpty(_info.FTContent))
    {
        [self showHUDText:@"发布内容不能为空"];
        return;
    }
    [self  requestPublistData];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)publishBtnItem
{
    if (!_publishBtnItem)
    {
        _publishBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(handlePublishBarButtonItem)];
    }
    return _publishBtnItem;
}

#pragma mark - network

- (void)requestPublistData
{
    [self showHUDView:nil];
    
    HCHomePublishApi *api = [[HCHomePublishApi alloc] init];
    
    api.FTImages = _uploadImageNameArr;
    api.FTContent = _info.FTContent;
    api.OpenAddress = _info.OpenAddress;
    api.PermitType = _info.PermitType;
    api.PermitUserArr = _info.PermitUserArr;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCHomeInfo *homeInfo) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            
            NSMutableArray *arrayM = self.data[@"data"];
            [arrayM insertObject:homeInfo atIndex:0];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
