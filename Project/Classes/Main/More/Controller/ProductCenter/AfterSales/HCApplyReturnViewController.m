//
//  HCApplyReturnViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReturnViewController.h"

#import "HCProductIntroductionInfo.h"

#import "HCApplyReturnOrderCell.h"
#import "HCApplyReturnDetailCell.h"
#import "HCApplyReturnReasonCell.h"

#import "HCApplyReissueResonApi.h"
#import "HCReturnReasonViewController.h"
#import "HCApplyReturnResonInfo.h"


@interface HCApplyReturnViewController () <HCApplyReturnReasonCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)HCProductIntroductionInfo *productInfo;
@property (nonatomic,strong) HCApplyReturnResonInfo *reasonInfo;
@property (nonatomic, assign) CGFloat editHeight;
@property (nonatomic,strong) UIView *footerView;
@end

@implementation HCApplyReturnViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"申请退货";
    _reasonInfo = [[HCApplyReturnResonInfo alloc]init];
    _reasonInfo.reason = @"0";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    
    _productInfo = self.data[@"data"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (cell == nil) {
        if (indexPath.section == 0)
        {
            HCApplyReturnOrderCell *applyReissueOrderCell = [tableView dequeueReusableCellWithIdentifier:@"orderInfo"];
            applyReissueOrderCell = [[HCApplyReturnOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderInfo"];
            applyReissueOrderCell.info = _productInfo;
            cell = applyReissueOrderCell;
            
        }
        else if(indexPath.section == 1)
        {
            if (indexPath.row==0)
            {
                UITableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:@"table"];
                tCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"table"];
                tCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                tCell.textLabel.text = @"退货原因";
                tCell.detailTextLabel.text =[HCDictionaryMgr applyReturnReason:_reasonInfo.reason];
                tCell.textLabel.font =[UIFont  systemFontOfSize:15];
                tCell.detailTextLabel.font = [UIFont systemFontOfSize:15];
                cell = tCell;
            }
            else
            {
                HCApplyReturnReasonCell *applyReissueReasonCell = [tableView dequeueReusableCellWithIdentifier:@"applyreason"];
                applyReissueReasonCell = [[HCApplyReturnReasonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"applyreason"];
                applyReissueReasonCell.info = _reasonInfo;
                applyReissueReasonCell.indexPath = indexPath;
                applyReissueReasonCell.delegate = self;
                
                cell = applyReissueReasonCell;
            }
        }
        else
        {
            HCApplyReturnDetailCell *applyReissueDetailCell = [tableView dequeueReusableCellWithIdentifier:@"applyReissueDetailCell"];
            applyReissueDetailCell = [[HCApplyReturnDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"applyReissueDetailCell"];
            applyReissueDetailCell.info = _reasonInfo;
            cell = applyReissueDetailCell;
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
    return (section == 1)?2:1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 200;
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 0 )
        {
            return 44;
        }
        else
        {
            return SCREEN_WIDTH/3+140;
        }
    }
    else
    {
        return 88;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section==2)?50:5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    return (section==2)?self.footerView :view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1 && indexPath.row == 0)
    {
        HCReturnReasonViewController *VC = [[HCReturnReasonViewController alloc]init];
        VC.data = @{@"data": _reasonInfo};
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - HCPublishTableViewCellDelegate

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (_reasonInfo.imageArray.count == index)
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [action showInView:self.view];
    }
}

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index
{
    [_reasonInfo.imageArray removeObjectAtIndex:index-1];
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
    
    if (_reasonInfo.imageArray.count >= 10)
    {
        [self showHUDText:@"最多只能发布9张图片"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [_reasonInfo.imageArray insertObject:image atIndex:_reasonInfo.imageArray.count-1];
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
    _reasonInfo.reason = text;
}

#pragma mark--private methods

-(void)clickApplyBtn
{
    [self showHUDText:@"提交申请"];
}

#pragma mark----Setter Or Getter

-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        applyBtn.frame = CGRectMake(10, 3, SCREEN_WIDTH-20, 44);
        [applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [applyBtn setBackgroundColor:[UIColor redColor]];
        [applyBtn addTarget:self action:@selector(clickApplyBtn) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(applyBtn, 4);
        [_footerView addSubview:applyBtn];
    }
    return _footerView;
}

- (void)handlePublishBarButtonItem
{
    if ( _reasonInfo.imageArray.count == 1)
    {
        [self showHUDText:@"发布内容不能为空"];
        return;
    }
    [self  requestReasonData];
}

#pragma mark - network

- (void)requestReasonData
{
    HCApplyReissueResonApi *api = [[HCApplyReissueResonApi alloc] init];
    
}

@end
