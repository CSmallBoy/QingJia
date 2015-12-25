//
//  HCAddressInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCAddressInfo : NSObject

/**
 *收货人姓名
 */
@property (nonatomic,strong) NSString *consigneeName;
/**
 *手机号码
 */
@property (nonatomic,strong)NSString*  phoneNumb;
/**
 *邮政编码
 */
@property (nonatomic,strong) NSString* postcode;
/**
 *收货省市区
 */
@property (nonatomic,strong) NSString *receivingCity;
/**
 *收货街道
 */
@property (nonatomic,strong) NSString *receivingStreet;
@end
