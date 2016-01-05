//
//  HCCustomerApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomerApi.h"
#import "HCCustomerInfo.h"

@implementation HCCustomerApi

- (void)startRequest:(HCCustomerBlock)requestBlock
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
        HCCustomerInfo *info = [[HCCustomerInfo alloc] init];
        if (i == 0)
        {
            info.orderID = @"11111111";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"1";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//待审核
            info.reason = @"0";
            info.detailReason = @"这张标签有问题，扫描不出来0";
            info.imgArr = @[@"time_picture",
                            @"time_picture"
                            ];
            
        }
        else if ( i==1 )
        {
            info.orderID = @"2222222";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"1";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 1;//审核通过
            info.reason = @"1";
            info.detailReason = @"这张标签有问题，扫描不出来1";
            info.imgArr = @[@"time_picture",
                            @"time_picture",
                            @"time_picture"];
        }
        else if (i == 2)
        {
            info.orderID = @"333333";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"1";
            info.detailOrderGoodsNum = @"4";
            info.detailNeedGoodsNum = @"2";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 2;//审核不通过
            info.reason = @"1";
            info.detailReason = @"这张标签有问题，扫描不出来2";
            info.auditNotPassReason = @"您好，给您发的标签用我们的app是可以扫描出信息的，所以该补发申请审核未能通过";
            info.imgArr = @[@"time_picture",
                            @"time_picture",
                            @"time_picture"];
        }
        else if (i == 3)
        {
            info.orderID = @"44444444";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"1";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 2;//审核不通过
            info.reason = @"2";
            info.detailReason = @"这张标签有问题，扫描不出来3";
            info.auditNotPassReason = @"您好，给您发的标签用我们的app是可以扫描出信息的，所以该补发申请审核未能通过";
            info.imgArr = @[@"label",
                            @"label",
                            @"label"];
        }
        else if (i == 4)
        {
            info.orderID = @"11111111";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"0";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//待审核
            info.reason = @"1";
            info.detailReason = @"这个烫印机有问题0";
            info.imgArr = @[@"label",
                            @"label",
                            @"label"];
            
        }
        else if (i == 5)
        {
            info.orderID = @"2222222";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"0";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 1;//审核通过
            info.detailReason = @"这个烫印机有问题1";
            info.imgArr = @[@"label",@"label",@"label"];
        }
        else if (i == 6)
        {
            info.orderID = @"333333";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"0";
            info.detailOrderGoodsNum = @"4";
            info.detailNeedGoodsNum = @"2";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 2;//审核不通过
            info.detailReason = @"这个烫印机有问题2";
            info.auditNotPassReason = @"您好，给您发的烫印机是可以烫印标签的，所以该退货申请审核未能通过";
            info.imgArr = @[@"label",@"label",@"label"];
        }
        else if (i == 7)
        {
            info.orderID = @"44444444";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"0";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 3;//退款成功
            info.detailReason = @"这个烫印机有问题4";
            info.imgArr = @[@"label",@"label",@"label"];
            info.RefundWhereabouts = @"0";//支付宝
        }
        else
        {
            info.orderID = @"44444444";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"0";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//待审核
            info.detailReason = @"这个烫印机有问题5";
            info.imgArr = @[@"label",@"label",@"label"];
        }
        
        [arrayM addObject:info];
    }
    
    return arrayM;
}


@end
