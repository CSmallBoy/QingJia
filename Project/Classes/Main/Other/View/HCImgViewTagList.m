//
//  HCImgViewTagList.m
//  Ordering
//
//  Created by 陈福杰 on 15/11/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCImgViewTagList.h"


@implementation HCImgViewTagList

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(ImgViewTagList:)])
    {
        [self.delegate ImgViewTagList:button.tag];
    }
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSArray *titleArr = array[i];
        
        CGFloat width = WIDTH(self)/array.count;
        UIButton *contentBtn= [[UIButton alloc] initWithFrame:CGRectMake(width*i, 0, width, HEIGHT(self))];
        contentBtn.tag = i;
        [contentBtn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect imgRect = CGRectMake(WIDTH(contentBtn)*0.2, 0, WIDTH(contentBtn)*0.6, WIDTH(contentBtn)*0.6);
        UIImageView *imgView = [self setupImageView:titleArr[0] frame:imgRect];
        imgView.userInteractionEnabled = NO;
        [contentBtn addSubview:imgView];
        
        CGRect titleRect = CGRectMake(0, MaxY(imgView)+5, WIDTH(contentBtn), 20);
        UILabel *titleL = [self setupTitle:titleArr[1] frame:titleRect];
        titleL.userInteractionEnabled = NO;
        [contentBtn addSubview:titleL];
        
        [self addSubview:contentBtn];
    }
}

- (UIImageView *)setupImageView:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = OrigIMG(imageName);
    return imgView;
}


- (UILabel *)setupTitle:(NSString *)title frame:(CGRect)frame
{
    UILabel *titleL = [[UILabel alloc] initWithFrame:frame];
    titleL.text = title;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:self.fontSize];
    titleL.textColor = DarkGrayColor;
    return titleL;
}

- (CGFloat)fontSize
{
    if (!_fontSize)
    {
        return 16;
    }
    return  _fontSize;
}


@end
