//
//  HCPerfectMessageApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCPerfectMessageBlock)(HCRequestStatus requestStatus, NSString *message, NSDictionary *data);

@interface HCPerfectMessageApi : HCRequest

@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *Token;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *TrueName;
@property (nonatomic, strong) NSString *UserPWD;
@property (nonatomic, strong) NSString *Sex;

- (void)startRequest:(HCPerfectMessageBlock)requestBlock;

@end
