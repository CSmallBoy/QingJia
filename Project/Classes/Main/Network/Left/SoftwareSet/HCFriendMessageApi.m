//
//  HCFriendMessageApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFriendMessageApi.h"
#import "HCFriendMessageInfo.h"

@implementation HCFriendMessageApi

- (void)startRequest:(HCFriendMessageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSInteger i = 1; i < 11; i++)
    {
        HCFriendMessageInfo *info = [[HCFriendMessageInfo alloc] init];
        info.uid = [NSString stringWithFormat:@"%@", @(i)];
        info.name = [NSString stringWithFormat:@"姓名-%@", @(i)];
        info.imageName = @"http://xiaodaohang.cn/1.jpg";
        if (i == 2 || i == 5)
        {
            info.imageName = @"http://xiaodaohang.cn/2.jpg";
        }else if (i == 3 || i ==8)
        {
            info.imageName = @"http://xiaodaohang.cn/3.jpg";
        }
        [arrayM addObject:info];
    }
    
    HCFriendMessageInfo *info = [[HCFriendMessageInfo alloc] init];
    info.uid = @"0";
    info.name = @"添加";
    info.imageName = @"add-members";
    [arrayM addObject:info];
    
    return arrayM;
}


@end
