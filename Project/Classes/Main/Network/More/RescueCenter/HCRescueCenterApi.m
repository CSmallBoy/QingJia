//
//  HCRescueCenter.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRescueCenterApi.h"
#import "HCRescueCenterInfo.h"

@implementation HCRescueCenterApi

-(void)startRequest:(HCResCueCenterBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *newsArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++)
    {
        HCRescueCenterInfo *info = [[HCRescueCenterInfo alloc] init];
        info.headerImageStr = @"http://www.xiaodaohang.cn/1.jpg";
        info.newsTitle = @"啊是大三的拉";
        info.detailNews = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
        info.urlStr = @"https://www.baidu.com";
        [newsArr addObject:info];
    }
    
    
    
    return newsArr;
}
@end
