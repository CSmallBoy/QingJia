//
//  HCHomeApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeApi.h"
#import "HCHomeInfo.h"

@implementation HCHomeApi

- (void)startRequest:(HCHomeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
     return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i ++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        info.imgName = @"http://www.xiaodaohang.cn/1.jpg";
        info.nickName = @"姓名测试";
        info.deviceModel = @"iphone 6";
        info.inputtime = @"1450236588";
        info.contents = @"丽日当空，泉山缭绕，簇簇的白色花朵像一条流动的江河，仿佛世间所有的生命都应约前来，在这刹那间，在透明如醇蜜的阳光下，同时欢呼，同时飞旋，同时幻化成无数游离的光点";
        info.zan = @"100";
        info.comments = @"0";
        
        if (i==1)
        {
            info.imgArr = @[@"http://www.xiaodaohang.cn/1.jpg"];
            info.address = @"上海市闵行区";
        }else if (i == 2)
        {
            info.imgArr = @[@"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/2.jpg"];
        }else if (i == 3)
        {
            info.imgArr = @[@"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/2.jpg", @"http://www.xiaodaohang.cn/3.jpg", @"http://www.xiaodaohang.cn/1.jpg"];
            info.address = @"上海市闵行区";
        }else if (i == 6 || i == 8 || i==10)
        {
            info.address = @"上海市闵行区";
        }
        
        [arrayM addObject:info];
    }
    
    return arrayM;
}

@end
