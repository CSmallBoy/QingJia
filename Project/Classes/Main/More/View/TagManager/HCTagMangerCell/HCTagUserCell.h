//
//  HCPromisedTagCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCNewTagInfo;

@interface HCTagUserCell : UICollectionViewCell

@property (nonatomic,strong) HCNewTagInfo *info;

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
