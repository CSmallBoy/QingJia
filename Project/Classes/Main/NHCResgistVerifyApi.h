//
//  NHCResgistVerifyApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//  验证验证码

#import "HCRequest.h"
typedef void(^HCRegisterVerify)(HCRequestStatus requestStatus, NSString *message, id data);
@interface NHCResgistVerifyApi : HCRequest
@property (nonatomic, strong) NSString *PhoneNumber;
@property (nonatomic, assign) NSString *theType;
@property (nonatomic, assign) NSString *theCode;
- (void)startRequest:(HCRegisterVerify)requestBlock;
@end
