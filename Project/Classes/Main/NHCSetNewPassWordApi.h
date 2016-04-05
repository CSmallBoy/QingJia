//
//  NHCSetNewPassWordApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCNewPW)(HCRequestStatus requestStatus, NSString *message, id data);
@interface NHCSetNewPassWordApi : HCRequest
- (void)startRequest:(NHCNewPW)requestBlock;
@property (nonatomic,copy) NSString *NewPassWord;
@property (nonatomic,copy) NSString *PhoneNum;
@end
