//
//  HCProductIntrodApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProductIntrodApi.h"
#import "HCProductIntroductionInfo.h"

@implementation HCProductIntrodApi

- (void)startRequest:(HCProductBlock)requestBlock
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
    
}

//- (id)requestArgument
//{
//    return @{@"t": @"User,logout", @"token": @"23"};
//}

- (id)formatResponseObject:(id)responseObject
{
        HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
    info.buyLabelNumber = 10;
    info.labelPrice = 8;
    info.buyHotStampingMachineNumber = 1;
    info.hotStampingMachinePrice = 70;
    info.totalPrice = 158;
    info.orderID = @"111111";
    info.orderState = 0;//待付款
    info.orderTime = @"2015-12-19 22:30";
    
    return info;
    
//    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
//    for (NSInteger i = 0; i < 10; i ++)
//    {
//        HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
//        if (i == 0)
//        {
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"11111111";
//            info.orderState = 0;//待付款
//            info.orderTime = @"2015-12-19 22:30";
//        }else if ( i==1 )
//        {
////            HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"2222222";
//            info.orderState = 1;//订单已取消
//            info.orderTime = @"2015-12-20 22:30";
//        }else if (i == 2)
//        {
////            HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"33333333";
//            info.orderState = 2;//待发货
//            info.orderTime = @"2015-12-21 22:30";
//        }else if (i == 3)
//        {
////            HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"44444444";
//            info.orderState = 3;//已发货
//            info.orderTime = @"2015-12-22 22:30";
//        }else if (i == 4)
//        {
////            HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"55555555";
//            info.orderState = 4;//已签收
//            info.orderTime = @"2015-12-23 22:30";
//        }
//        else
//        {
//            info.buyLabelNumber = 10;
//            info.labelPrice = 8;
//            info.buyHotStampingMachineNumber = 1;
//            info.hotStampingMachinePrice = 70;
//            info.totalPrice = 158;
//            info.orderID = @"55555555";
//            info.orderState = 4;//已签收
//            info.orderTime = @"2015-12-23 22:30";
//        }
//        
//        [arrayM addObject:info];
//    }
//    
//    return arrayM;
}

@end