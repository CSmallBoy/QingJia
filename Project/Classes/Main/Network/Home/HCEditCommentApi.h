//
//  HCEditCommentApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCEditCommentInfo;

typedef void(^HCEditCommentBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCEditCommentApi : HCRequest

@property (nonatomic, strong) HCEditCommentInfo *commentInfo;

- (void)startRequest:(HCEditCommentBlock)requestBlock;

@end
