//
//  HCButtonItem.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCButtonItem : UIControl

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *label;

-(instancetype)initWithFrame:(CGRect)frame WithImageName:(NSString *)imageName WithImageWidth:(CGFloat)imgWidth WithImageHeightPercentInItem:(CGFloat)imgPercent WithTitle:(NSString *)title WithFontSize:(CGFloat)fontSize WithFontColor:(UIColor *)color WithGap:(CGFloat)gap;
@end
