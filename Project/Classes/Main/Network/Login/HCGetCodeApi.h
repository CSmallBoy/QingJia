//
//  HCGetCodeApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCGetCodeBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCGetCodeApi : HCRequest

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, assign) NSInteger thetype;

- (void)startRequest:(HCGetCodeBlock)requestBlock;

@end
