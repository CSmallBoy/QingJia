//
//  HCAddressApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HCAddressInfo;

typedef void(^HCAddressBlock)(HCRequestStatus requestStatus, NSString *message, HCAddressInfo *info);

@interface HCAddressApi : HCRequest



- (void)startRequest:(HCAddressBlock)requestBlock;
@end
