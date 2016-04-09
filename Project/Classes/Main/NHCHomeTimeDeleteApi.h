//
//  NHCHomeTimeDeleteApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void (^NHCDeleteTime)(HCRequestStatus resquestStatus,NSString *message,NSArray* array);
@interface NHCHomeTimeDeleteApi : HCRequest
- (void)startRequest:(NHCDeleteTime)requestBlock;
@end
