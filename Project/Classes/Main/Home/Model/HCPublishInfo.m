//
//  HCPublishInfo.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPublishInfo.h"

@implementation HCPublishInfo


- (NSMutableArray *)FTImages
{
    if (!_FTImages)
    {
        _FTImages = [NSMutableArray array];
        [_FTImages addObject:[UIImage imageNamed:@"Add-Images"]];
    }
    return _FTImages;
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
