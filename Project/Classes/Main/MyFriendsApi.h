//
//  MyFriendsApi.h
//  钦家
//
//  Created by 殷易辰 on 16/6/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCChatUSer)(HCRequestStatus requestStatus,NSString *message,id responseObject);
@interface MyFriendsApi : HCRequest

-(void)startRequest:(NHCChatUSer)requestBlock;

@end
