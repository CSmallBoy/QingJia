//
//  NHCLoginApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void (^NHCLogin)(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo);
@interface NHCLoginApi : HCRequest
- (void)startRequest:(NHCLogin)requestBlock;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *UserPWD;
@end
