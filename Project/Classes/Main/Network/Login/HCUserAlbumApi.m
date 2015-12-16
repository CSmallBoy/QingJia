//
//  HCUserAlbumApi.m
//  Project
//
//  Created by 陈福杰 on 15/11/26.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUserAlbumApi.h"

@implementation HCUserAlbumApi

- (void)startRequest:(HCUserAlbumBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    NSDictionary *dic = @{@"t": @"Frame,file", @"ids": _bodyArr};
    return dic;
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"data"];
}

@end
