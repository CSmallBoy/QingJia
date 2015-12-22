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
 * 产品
 */
@property (nonatomic,assign)BOOL   selectState;

@end
