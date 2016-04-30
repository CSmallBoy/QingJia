//
//  HCEditCommentInfo.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentInfo.h"

@implementation HCEditCommentInfo

- (NSMutableArray *)FTImages
{
    if (!_FTImages)
    {
        _FTImages = [NSMutableArray array];
        //[_FTImages addObject:OrigIMG(@"Add-Images")];
    }
    return _FTImages;
}

@end
