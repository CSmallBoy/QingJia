//
//  HCBuyRecordApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCProductIntroductionInfo;

typedef void(^HCProductBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCBuyRecordApi : HCRequest

- (void)startRequest:(HCProductBlock)requestBlock;
@end
