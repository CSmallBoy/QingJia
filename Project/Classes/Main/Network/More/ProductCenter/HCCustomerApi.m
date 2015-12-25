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
            info.goodsName = @"退货商品:M-Talk二维码标签";
            info.goodsTotalNumb = @"订单张数";
            info.goodsNeedNumb = @"补货张数";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//待审核
            
        }else if ( i==1 )
        {
            info.orderID = @"2222222";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"退货商品:M-Talk二维码标签";
            info.goodsTotalNumb = @"订单张数";
            info.goodsNeedNumb = @"补货张数";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 1;//审核通过
        }else if (i == 2)
        {
            info.orderID = @"333333";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"补货商品:M-Talk烫印机";
            info.goodsTotalNumb = @"订单个数";
            info.goodsNeedNumb = @"补货个数";
            info.detailOrderGoodsNum = @"4";
            info.detailNeedGoodsNum = @"2";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 2;//审核不通过
        }else if (i == 3)
        {
            info.orderID = @"44444444";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"补货商品:M-Talk二维码标签";
            info.goodsTotalNumb = @"订单张数";
            info.goodsNeedNumb = @"退货张数";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//退款成功
        }else
        {
            info.orderID = @"55555555";
            info.orderTime = @"2015-12-19 22:30";
            info.goodsName = @"补货商品:M-Talk二维码标签";
            info.goodsTotalNumb = @"订单张数";
            info.goodsNeedNumb = @"补货张数";
            info.detailOrderGoodsNum = @"10";
            info.detailNeedGoodsNum = @"1";
            info.orderTotalPrice = @"88";
            info.orderCustomerState = 0;//待审核
        
        }
        
        [arrayM addObject:info];
    }
    
    return arrayM;
}


@end
