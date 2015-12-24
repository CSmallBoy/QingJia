//
//  HCScanViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCScanViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "lhScanQCodeViewController.h"

@interface HCScanViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong)  lhScanQCodeViewController *lhScanVC;

@end

@implementation HCScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ScanID = @"Scan";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScanID];
    if (!cell ) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ScanID];
    }
    cell.textLabel.text = @"1";
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - DZNEmptyDataSetDelegate, DZNEmptyDataSetSource

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return OrigIMG(@"label");
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self clickScan];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return HEIGHT(self.view)*0.19;
}

-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return IsEmpty(self.dataSource);
}

#pragma mark - private methods

-(void)clickScan
{
     _lhScanVC= [[lhScanQCodeViewController alloc]init];
    _lhScanVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_lhScanVC animated:YES];
}


#pragma mark --- Setter OR  Getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"ThinkChange_sel") style:UIBarButtonItemStylePlain target:self action:@selector(clickScan)];
        _rightItem.tintColor = [UIColor whiteColor];
    }
    return _rightItem;
}

//禁止扫描界面的旋转，横屏
-(BOOL)shouldAutorotate
{
    return  NO;
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
