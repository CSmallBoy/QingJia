//
//  HCPublishInfo.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPublishInfo.h"

@implementation HCPublishInfo


- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray array];
        [_imageArray addObject:[UIImage imageNamed:@"Add-Images"]];
    }
    return _imageArray;
}

- (NSMutableArray *)showPeopleArr
{
    if (!_showPeopleArr)
    {
        _showPeopleArr = [NSMutableArray array];
    }
    return _showPeopleArr;
}


@end
