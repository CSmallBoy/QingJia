//
//  HCMtalkShopingCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkShopingCell.h"
#import "HCMtalkShopingInfo.h"

@interface HCMtalkShopingCell ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UILabel  *priceLabel;
@property (nonatomic,strong) UILabel  *discountLabel;
@end

@implementation HCMtalkShopingCell

+(instancetype)costomCellWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath*)indexpath
{
     static NSString *ID = @"mtablkCell";
    
    HCMtalkShopingCell *cell = [collection dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexpath];
    
    [cell addSubviews];
    
    return cell;
}

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.discountLabel];
    
    
}


#pragma mark --- setter or getter


-(void)setInfo:(HCMtalkShopingInfo *)info
{
    _info = info;
    self.titleLabel.text = info.title;
    self.priceLabel.text = info.price;
    self.discountLabel.text = info.discount;

}


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-10)/2, 190/668.0*SCREEN_HEIGHT)];
        _imageView.image = IMG(@"girl");
    }
    return _imageView;
}


- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), (SCREEN_WIDTH-10)/2, 20/668.0*SCREEN_HEIGHT)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}


- (UILabel *)priceLabel
{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+10, 60/375.0*SCREEN_WIDTH, 20/668.0*SCREEN_HEIGHT)];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}


- (UILabel *)discountLabel
{
    if(!_discountLabel){
        _discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+15, CGRectGetMaxY(self.titleLabel.frame)+10,80/375.0*SCREEN_WIDTH, 15/668.0*SCREEN_HEIGHT)];
        _discountLabel.backgroundColor = COLOR(47, 122, 222, 1);
        ViewRadius(_discountLabel, 7.5);
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.font = [UIFont systemFontOfSize:12];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _discountLabel;
}





@end
