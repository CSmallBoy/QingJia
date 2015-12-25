//
//  HCLogisticsApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCLogisticsBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCLogisticsApi : HCRequest

- (void)startRequest:(HCLogisticsBlock)requestBlock;
@end
