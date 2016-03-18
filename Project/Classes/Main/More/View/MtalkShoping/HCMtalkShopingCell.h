//
//  HCMtalkShopingCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCMtalkShopingInfo;
@interface HCMtalkShopingCell : UICollectionViewCell

@property (nonatomic,strong) HCMtalkShopingInfo *info;

+(instancetype)costomCellWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath*)indexpath;

@end
