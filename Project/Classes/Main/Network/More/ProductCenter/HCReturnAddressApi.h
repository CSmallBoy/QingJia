//
//  HCReturnAddress.h
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCReturnAddressInfo;

typedef void(^HCReturnAddressBlock)(HCRequestStatus requestStatus, NSString *message, HCReturnAddressInfo *info);

@interface HCReturnAddressApi : HCRequest



- (void)startRequest:(HCReturnAddressBlock)requestBlock;
@end
