//
//  HCReturnAddress.h
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCReturnAddressInfo : NSObject
/**
 *公司地址
 */
@property (nonatomic,strong) NSString *returnAddress;
/**
 *收件人
 */
@property (nonatomic,strong) NSString *recipient;
/**
 *联系方式
 */
@property (nonatomic,strong) NSString *phoneNum;
@end
