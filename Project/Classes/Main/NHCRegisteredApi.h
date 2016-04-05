//
//  NHCRegisteredApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^HCRegister)(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo);
@interface NHCRegisteredApi : HCRequest
@property (nonatomic,copy) NSString *TrueName;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *passWord;
@property (nonatomic,copy) NSString *userName;

- (void)startRequest:(HCRegister)requestBlock;
@end
