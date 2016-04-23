//
//  HCCommentListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCCommentListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);


@interface HCCommentListApi : HCRequest

@property (nonatomic,strong)NSString *callId;
@property (nonatomic,strong)NSString *_start;
@property (nonatomic,strong)NSString *_count;

-(void)startRequest:(HCCommentListBlock)requestBlock;

@end
