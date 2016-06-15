//
//  HCDeleteMember.h
//  钦家
//
//  Created by 殷易辰 on 16/6/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCEditCommentBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCDeleteMember : HCRequest


@property (nonatomic, copy) NSString *memberUserId;

- (void)startRequest:(HCEditCommentBlock)requestBlock;

@end
