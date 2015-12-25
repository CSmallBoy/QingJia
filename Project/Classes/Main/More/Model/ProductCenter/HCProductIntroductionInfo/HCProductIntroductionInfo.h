//
//  HCProductIntroductionInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCProductIntroductionInfo : NSObject

/**
 *  标签购买数量
 */
@property (nonatomic,assign) int buyLabelNumber;

/**
 * 标签价格
 */
@property (nonatomic,assign) int labelPrice;

/**
 *  烫印机购买数量
 */
@property (nonatomic,assign) int buyHotStampingMachineNumber;

/**
 * 烫印机价格
 */
@property (nonatomic,assign) int hotStampingMachinePrice;

/**
 * 总价格
 */
@property (nonatomic,assign) int totalPrice;

/**
 * 订单编号
 */
@property (nonatomic,strong) NSString* orderID;;

/**
 *订单时间
 */
@property (nonatomic,strong) NSString* orderTime;

/**
 *订单状态
 */
@property (nonatomic,assign) int orderState;


@end
