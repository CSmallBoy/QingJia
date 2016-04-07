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
        info.userId = [NSString stringWithFormat:@"%@", @(i)];
        info.nickName = [NSString stringWithFormat:@"姓名-%@", @(i)];
        
        if (i == 2 || i == 5)
        {
        }else if (i == 3 || i ==8)
        {
          
        }
        [arrayM addObject:info];
    }
    
    HCFriendMessageInfo *info = [[HCFriendMessageInfo alloc] init];
  
    
    return arrayM;
}


@end
