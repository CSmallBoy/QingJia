//
//  HCHomePictureDetailApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomePictureDetailApi.h"
#import "HCHomeInfo.h"

@implementation HCHomePictureDetailApi

- (void)startRequest:(HCHomePictureDetailBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *commentsArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        info.imgName = @"http://xiaodaohang.cn/2.jpg";
        info.nickName = @"姓名";
        info.inputtime = [NSString stringWithFormat:@"%@", [Utils transformServerDate:1450430935]];
        info.comments = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
        [commentsArr addObject:info];
    }
    
    return commentsArr;
}

@end
