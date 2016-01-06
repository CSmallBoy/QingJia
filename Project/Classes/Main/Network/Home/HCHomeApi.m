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

- (NSString *)requestUrl
{
    return @"User/AuthCode.ashx";// 测试
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    //测试
    NSDictionary *cshead = @{@"Action": @"ReGet", @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *cspara = @{@"PhoneNumber": @(18012345678), @"theType": @(1000)};
    NSDictionary *csbody = @{@"Head": cshead, @"Para": cspara};
    return @{@"json": [Utils stringWithObject:csbody]};
    
    
    NSDictionary *head = @{@"Action": @"GetList", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid};
    NSDictionary *result = @{@"Start":@(_Start), @"Count": @(_Count)};
    NSDictionary *body = @{@"Head": head, @"Result": result};
    
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i ++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        info.imgName = @"http://www.xiaodaohang.cn/1.jpg";
        info.nickName = @"姓名测试";
        info.deviceModel = [Utils systemModel];
        info.inputtime = @"1450236588";
        info.contents = @"丽日当空，泉山缭绕，簇簇的白色花朵像一条流动的江河，仿佛世间所有的生命都应约前来，在这刹那间，在透明如醇蜜的阳光下，同时欢呼，同时飞旋，同时幻化成无数游离的光点";
        info.zan = [NSString stringWithFormat:@"%@", @(i)];
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
            info.imgArr = @[@"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/2.jpg", @"http://www.xiaodaohang.cn/3.jpg", @"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/3.jpg", @"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/1.jpg", @"http://www.xiaodaohang.cn/1.jpg"];
            info.address = @"上海市闵行区";
        }else if (i == 6 || i == 8 || i==10)
        {
            info.address = @"上海市闵行区梅陇镇502室";
        }
        
        [arrayM addObject:info];
    }
    
    return arrayM;
}

@end
