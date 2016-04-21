//
//  NHCMessageSearchUserApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/20.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCMeaaageUser)(HCRequestStatus requestStatus,NSString *message,NSString * Tid);
@interface NHCMessageSearchUserApi : HCRequest
-(void)startRequest:(NHCMeaaageUser)requestBlock;
@end
