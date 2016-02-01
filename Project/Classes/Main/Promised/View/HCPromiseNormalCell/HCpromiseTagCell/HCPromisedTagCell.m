//
//  HCPromisedTagCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTagCell.h"
#import "HCPromisedTagInfo.h"


#define CellW  SCREEN_WIDTH/4-15

@interface HCPromisedTagCell ()

@property(nonatomic,strong) UIImageView  *imageView;
@property(nonatomic,strong) UILabel      *nameLabel;

@end



@implementation HCPromisedTagCell

#pragma mark -- private   methods

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedTagCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCellID" forIndexPath:indexPath];
    
    [cell addSubviews];
    return cell;
}

-(void)addSubviews
{
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self addSubview:self.imageView];
    [self addSubview:self.nameLabel];
  
}

#pragma mark --- getter Or setter


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 5, CellW -26, CellW-26)];
        _imageView.backgroundColor = [UIColor yellowColor];
        ViewRadius(_imageView, (CellW-26)/2);
    }
    return _imageView;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, CellW-20, CellW-26, 20)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"名字";
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}



@end
