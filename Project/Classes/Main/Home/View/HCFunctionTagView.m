//
//  HCFunctionTagView.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFunctionTagView.h"

@implementation HCFunctionTagView

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcfunctionTagViewButtonIndex:)])
    {
        [self.delegate hcfunctionTagViewButtonIndex:button.tag];
    }
}

- (void)functionTagWithArrary:(NSArray *)array
{
    [self removeAllSubviews];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), 1)];
    topLine.backgroundColor = RGB(220, 220, 220);
    [self addSubview:topLine];
    
    for (NSInteger i = 0; i < array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonW = WIDTH(self)/array.count;
        button.frame = CGRectMake(i*buttonW, 0, buttonW, 30);
        [self addSubview:button];
        
        NSArray *valueArr = array[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 15, 15)];
        imgView.image = OrigIMG(valueArr[0]);
        [button addSubview:imgView];
        
        UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imgView)+10, 0, WIDTH(button)*0.7, self.frame.size.height)];
        value.text = valueArr[1];
        value.textColor = [UIColor lightGrayColor];
        value.font = [UIFont systemFontOfSize:14];
        [button addSubview:value];
        
        if (i != array.count - 1)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(MaxX(button)-1, 5, 1, self.frame.size.height-10)];
            line.backgroundColor = RGB(220, 220, 220);
            [self addSubview:line];
        }
    }
}

- (NSMutableArray *)valueLableArr
{
    if (!_valueLableArr)
    {
        _valueLableArr = [NSMutableArray array];
    }
    return _valueLableArr;
}

@end
