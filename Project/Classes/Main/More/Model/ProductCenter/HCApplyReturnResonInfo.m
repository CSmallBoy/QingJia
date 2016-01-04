//
//  HCApplyReturnResonInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReturnResonInfo.h"

@implementation HCApplyReturnResonInfo

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
