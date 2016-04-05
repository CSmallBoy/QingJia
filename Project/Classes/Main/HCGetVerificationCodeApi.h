//
//  HCGetVerificationCodeApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^HCGetCode)(HCRequestStatus requestStatus, NSString *message, id data);
@interface HCGetVerificationCodeApi : HCRequest
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, assign) NSString *thetype;
- (void)startRequest:(HCGetCode)requestBlock;
@end
