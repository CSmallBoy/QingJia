//
//  HCJurisdictionViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
// 默认权限设置

#import "HCJurisdictionViewController.h"
#import "HCFriendMessageViewController.h"

@interface HCJurisdictionViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, assign) NSInteger selected;

@property (nonatomic, strong) NSMutableArray *permitUserArr; // 不可见好友数组

@end

@implementation HCJurisdictionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"权限设置";
    [self setupBackItem];
    
    _selected = 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jurisdiction"];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    if (_selected == indexPath.row)
    {
        cell.imageView.image = OrigIMG(@"select");
    }else
    {
        cell.imageView.image = OrigIMG(@"left_white");
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == self.titleArr.count-1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 3)
    {
        _selected = indexPath.row;
        [self.tableView reloadData];
    }else
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WIDTH(self.view)*0.18, WIDTH(self.view)*0.23);
        CGFloat paddingY = 10;
        CGFloat paddingX = 20;
        layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
        layout.minimumInteritemSpacing = paddingY;
        
        HCFriendMessageViewController *friendMessage = [[HCFriendMessageViewController alloc] initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:friendMessage animated:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(hcJurisdictionViewControllerWithPermitType:permitUserArr:)])
    {
        NSString *permitType = [NSString stringWithFormat:@"%@", @(indexPath.row+100)];
        [self.delegate hcJurisdictionViewControllerWithPermitType:permitType permitUserArr:_permitUserArr];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"所有人可见", @"仅自己可见"];
    }
    return _titleArr;
}


@end
