//
//  NHCBindPhoneNumAPi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCUserInfo)(HCRequestStatus requestStatus, NSString *message, NSArray *array);
@interface NHCBindPhoneNumAPi : HCRequest
- (void)startRequest:(NHCUserInfo)requestBlock;
@end
