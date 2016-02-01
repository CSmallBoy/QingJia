//
//  HCApplyReissueResonInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReissueResonInfo.h"

@implementation HCApplyReissueResonInfo


- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray array];
        [_imageArray addObject:[UIImage imageNamed:@"Aftermarket_Photo"]];
    }
    return _imageArray;
}

@end
