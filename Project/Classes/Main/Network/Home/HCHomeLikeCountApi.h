//
//  HCHomeLikeCountApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCHomeLikeCountBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCHomeLikeCountApi : HCRequest

@property (nonatomic, strong) NSString *TimesId;

- (void)startRequest:(HCHomeLikeCountBlock)requestBlock;

@end
