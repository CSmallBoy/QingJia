//
//  HCBuyRecordApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCBuyRecordApi.h"
#import "HCProductIntroductionInfo.h"

@implementation HCBuyRecordApi

- (void)startRequest:(HCProductBlock)requestBlock
{
    [super startRequest:requestBlock];
}
//测试
- (NSString *)requestUrl
{
    return @"HelpCase/HelpCase.ashx";
}


- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList"};
    
    NSDictionary *result = @{@"Start" : @(1000), @"Count" : @(20)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i ++)
    {
        HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
        if (i == 0)
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"11111111";
            info.orderState = 0;//待付款
            info.orderTime = @"2015-12-19 22:30";
        }else if ( i==1 )
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"2222222";
            info.orderState = 1;//订单已取消
            info.orderTime = @"2015-12-20 22:30";
        }else if (i == 2)
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"33333333";
            info.orderState = 2;//待发货
            info.orderTime = @"2015-12-21 22:30";
        }else if (i == 3)
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"44444444";
            info.orderState = 3;//已发货
            info.orderTime = @"2015-12-22 22:30";
        }else if (i == 4)
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"55555555";
            info.orderState = 4;//已签收
            info.orderTime = @"2015-12-23 22:30";
        }
        else if(i == 5)
        {
            info.buyLabelNumber = 10;
            info.labelPrice = 8;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = @"66666666";
            info.orderState = 4;//已签收
            info.orderTime = @"2015-12-23 22:30";
        }
        else
        {
            info.buyLabelNumber = 11;
            info.labelPrice = 3;
            info.buyHotStampingMachineNumber = 1;
            info.hotStampingMachinePrice = 70;
            info.totalPrice = 158;
            info.orderID = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld%ld%ld",(long)i,(long)i,(long)i,(long)i,(long)i,(long)i,(long)i,(long)i];
            info.orderState = 4;//已签收
            info.orderTime = @"2015-12-23 22:30";
        }
        
        [arrayM addObject:info];
    }
    
    return arrayM;
}

@end
