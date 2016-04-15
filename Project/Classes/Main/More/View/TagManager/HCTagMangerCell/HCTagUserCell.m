//
//  HCPromisedTagCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserCell.h"

#import "HCNewTagInfo.h"

#define CellW  SCREEN_WIDTH/3-10

@interface HCTagUserCell ()

@property(nonatomic,strong) UIImageView  *imageView;
@property(nonatomic,strong) UILabel      *nameLabel;

@end



@implementation HCTagUserCell

#pragma mark -- private   methods

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    HCTagUserCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCellID" forIndexPath:indexPath];
    
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

-(void)setInfo:(HCNewTagInfo *)info
{
    _info = info;
    
    self.nameLabel .text = info.trueName;
    NSURL *url = [readUserInfo originUrl:info.imageName :kkUser];
    [self.imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
}


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, CellW -30, CellW-30)];
        _imageView.backgroundColor = [UIColor yellowColor];
        ViewRadius(_imageView, (CellW-30)/2);
        
        _imageView.layer.borderWidth = 2;
        _imageView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _imageView;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, CellW-20, CellW-26, 20)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}



@end
