//
//  HCMySaveListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
//  -----------------收藏列表----------------------
typedef void(^HCMySaveListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCMySaveListApi : HCRequest

- (void)startRequest:(HCMySaveListBlock)requestBlock;

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *_start;
@property (nonatomic, strong) NSString *_count;

@end
