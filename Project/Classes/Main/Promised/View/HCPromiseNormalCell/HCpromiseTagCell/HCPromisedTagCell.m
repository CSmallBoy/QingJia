//
//  HCPromisedTagCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTagCell.h"
#import "HCNewTagInfo.h"


#define CellW  SCREEN_WIDTH/3-10
#define CellH  SCREEN_WIDTH/3
@interface HCPromisedTagCell ()

@property(nonatomic,strong) UIImageView  *imageView;
@property(nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UIImageView *selectIV;

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
    [self addSubview:self.selectIV];
  
}



#pragma mark --- getter Or setter

-(void)setInfo:(HCNewTagInfo *)info
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@",info.labelTitle];
    
    if (info.isBlack) {// 选中
        
        self.selectIV.image = IMG(@"buttonSelected");
        
    }
    else
    {
        self.selectIV.image = IMG(@"buttonNormal");
    }
}

- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, CellW-40 , CellW-40)];
        _imageView.image = IMG(@"2Dbarcode");
    }
    return _imageView;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, CellW-30, CellW-26, 20)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}


- (UIImageView *)selectIV
{
    if(!_selectIV){
        
        CGFloat   cellW = (SCREEN_WIDTH-10)/3;
        _selectIV = [[UIImageView alloc]initWithFrame:CGRectMake(cellW/2-10, CellH-25, 20, 20)];
    }
    return _selectIV;
}



@end
