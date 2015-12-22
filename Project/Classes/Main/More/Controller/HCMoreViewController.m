//
//  HCMoreViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCMoreViewController.h"
#import "HCTagManagerViewController.h"
#import "HCAddItemViewController.h"
#import "HClassCalendarViewController.h"
#import "HCNotificationViewController.h"
#import "HCProducCenterViewController.h"
#import "HCPromisedViewController.h" // 一呼百应
#import "HCRescueCenterViewController.h" // 救助中心
#import "HCTimeViewController.h"
#import "HCMoreCollectionViewCell.h"
#import "HCMoreInfo.h"

@interface HCMoreViewController()

@property (nonatomic, strong) NSMutableArray *TagArr;
@property (nonatomic, strong) NSArray *vClassNameArr;

@end

@interface HCMoreViewController ()

@end

@implementation HCMoreViewController

static NSString * const reuseIdentifier = @"moreCollectionCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[HCMoreCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.info = self.TagArr[indexPath.section*3+indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vCName = self.vClassNameArr[indexPath.section*3+indexPath.row];
    HCViewController *vc = [[NSClassFromString(vCName) alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ((int)self.TagArr.count/3+1);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ((self.TagArr.count/3) == section)
    {
        return (self.TagArr.count % 3);
    }
    return 3;
}



#pragma mark - setter or getter

- (NSMutableArray *)TagArr
{
    if (!_TagArr)
    {
        NSArray *titleArr = @[@"通知中心", @"时间轴", @"救助中心", @"班级日历",
                              @"标签管理", @"产品中心", @"一呼百应", @"添加"];
        NSArray *imageNameArr = @[@"Notice", @"Timeline", @"Salve", @"Calendar",
                               @"label", @"Products", @"hopne", @"Classinfo_but_plus"];
        _TagArr = [NSMutableArray arrayWithCapacity:8];
        for (NSInteger i = 0; i < 8; i++)
        {
            HCMoreInfo *info = [[HCMoreInfo alloc] init];
            info.title = titleArr[i];
            info.imageName = imageNameArr[i];
            info.isShow = YES;
            [_TagArr addObject:info];
        }
    }
    return _TagArr;
}

- (NSArray *)vClassNameArr
{
    if (!_vClassNameArr)
    {
        _vClassNameArr = @[@"HCNotificationViewController", @"HCTimeViewController",
                           @"HCRescueCenterViewController", @"HClassCalendarViewController",
                           @"HCTagManagerViewController", @"HCProducCenterViewController",
                           @"HCPromisedViewController", @"HCAddItemViewController"];
    }
    return _vClassNameArr;
}


@end
