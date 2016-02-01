//
//  HCPromisedTagCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCPromisedTagInfo;
@interface HCPromisedTagCell : UICollectionViewCell

@property (nonatomic,strong) HCPromisedTagInfo  *tagInfo;

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
