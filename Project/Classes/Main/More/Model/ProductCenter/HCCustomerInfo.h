//
//  HCCustomerInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCustomerInfo : NSObject
/**
 *订单编号
 */
@property (nonatomic,strong) NSString *orderID;
/**
 *订单时间
 */
@property (nonatomic,strong) NSString *orderTime;
/**
 *补货/退货商品名
 */
@property (nonatomic,strong) NSString *goodsName;
/**
 *订单张数/个数
 */
@property (nonatomic,strong) NSString *goodsTotalNumb;
/**
 *需要补货/退货张/个数
 */
@property (nonatomic,strong) NSString *goodsNeedNumb;

/**
 *具体订单商品数量
 */
@property (nonatomic,strong) NSString *detailOrderGoodsNum;
/**
 *具体补货张数
 */
@property (nonatomic,strong) NSString *detailNeedGoodsNum;
/**
 *订单总价
 */
@property (nonatomic,strong) NSString *orderTotalPrice;
/**
 *订单售后状态
 */
@property (nonatomic,assign) int orderCustomerState;

/**
 *退货原因
 */
@property (nonatomic,strong) NSString *reason;
/**
 *具体原因
 */
@property (nonatomic,strong) NSString *detailReason;
/**
 *退货图片
 */
@property (nonatomic,strong) NSArray *imgArr;

/**
 *审核不通过原因
 */
@property (nonatomic,strong) NSString *auditNotPassReason;

/**
 *退款去向
 */
@property (nonatomic,strong) NSString *RefundWhereabouts;

@end
