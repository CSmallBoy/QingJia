//
//  HCCustomerApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//售后API

#import "HCRequest.h"




typedef void(^HCCustomerBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCCustomerApi : HCRequest

- (void)startRequest:(HCCustomerBlock)requestBlock;
@end
