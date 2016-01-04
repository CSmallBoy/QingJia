//
//  HCDicDataMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/18.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCDictionaryMgr.h"

@interface HCDictionaryMgr ()

@property (nonatomic, strong) NSMutableArray *dictionaryStack;

@end

@implementation HCDictionaryMgr

+ (NSString *)applyReissueReason:(NSString *)key
{
    NSDictionary *dic = @{@"0":@"二维码标签扫描不出信息",@"1":@"标签残缺",@"2":@"其他"};
    return dic[key];
}
+ (NSString *)applyReturnReason:(NSString *)key
{
    NSDictionary *dic = @{@"0":@"不通电",@"1":@"不能烫印标签",@"2":@"其他"};
    return dic[key];
}


@end
