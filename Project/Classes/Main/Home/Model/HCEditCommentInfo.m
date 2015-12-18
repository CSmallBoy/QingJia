//
//  HCEditCommentInfo.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentInfo.h"

@implementation HCEditCommentInfo

- (NSMutableArray *)imageArr
{
    if (!_imageArr)
    {
        _imageArr = [NSMutableArray array];
        [_imageArr addObject:OrigIMG(@"Add-Images")];
    }
    return _imageArr;
}

@end
