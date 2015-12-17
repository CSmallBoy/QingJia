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
 *购买方式 1
 */
@property(nonatomic,strong) NSString *buyWayFirst;

/**
 *购买方式 2
 */
@property(nonatomic,strong) NSString *buyWaySecond;
/**
 *数量
 */
@property (nonatomic,assign) int buyNumber;

/**
 * 价格
 */
@property (nonatomic,assign) int price;

/**
 * 产品
 */
@property (nonatomic,strong) NSString *productName;

/**
 * 产品
 */
@property (nonatomic,assign)BOOL   selectState;
@end
