//
//  HCCheckCodeApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCCheckCodeBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCCheckCodeApi : HCRequest

@property (nonatomic, strong) NSString *PhoneNumber;
@property (nonatomic, assign) NSInteger theType;
@property (nonatomic, assign) NSInteger theCode;

- (void)startRequest:(HCCheckCodeBlock)requestBlock;

@end
