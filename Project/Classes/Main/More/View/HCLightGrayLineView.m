//
//  HCLightGrayLineView.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCLightGrayLineView.h"

@implementation HCLightGrayLineView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = LightGraryColor;
    }
    return self;
}

@end
