//
//  HCMtalkReturnReason.m
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkReturnReason.h"

@interface HCMtalkReturnReason ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSArray *titleArr;
@end

@implementation HCMtalkReturnReason

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退货原因";
    [self setupBackItem];
    _arr =[NSMutableArray arrayWithArray: @[@"1",@"2",@"2"]];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if ([_arr[indexPath.row] isEqualToString:@"1"]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 30, 30)];
        imageView.image = IMG(@"select");
        [cell addSubview:imageView];  
    }
    
   self.titleArr= @[@"不通电",@"不能烫印标签",@"其他"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 6, 200, 30)];
    label.text = self.titleArr[indexPath.row];
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    
    [cell addSubview:label];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [_arr removeAllObjects];
    
    for (int i = 0; i<3; i++) {
        
        if (i == indexPath.row) {
            [_arr addObject:@"1"];
        }
        else
        {
            [_arr addObject:@"2"];
        }
    }
    [self.tableView reloadData];
    
    self.block(self.titleArr[indexPath.row]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
