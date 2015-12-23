//
//  HCRefreshHeader.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRefreshHeader.h"

@implementation HCRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 30;
    
    // 添加label
    [self addSubview:self.topLabel];
}


- (UILabel *)topLabel
{
    if (!_topLabel)
    {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textColor = LightGraryColor;
        _topLabel.text = @"班级号创建于2015年11月30日(下滑班级照出现，松手班级照收回)";
    }
    return _topLabel;
}


@end
