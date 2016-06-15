//
//  NHCChatUserInfoApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCChatUSer1)(HCRequestStatus requestStatus,NSString *message,NSDictionary * dict);
@interface NHCChatUserInfoApi : HCRequest
-(void)startRequest:(NHCChatUSer1)requestBlock;
@property (nonatomic,copy) NSString *chatName;
@end
