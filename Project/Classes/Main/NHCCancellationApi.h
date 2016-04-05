//
//  NHCCancellationApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCCancel)(HCRequestStatus requestStatus, NSString *message, NSArray *array);
@interface NHCCancellationApi : HCRequest
- (void)startRequest:(NHCCancel)requestBlock;
@end
