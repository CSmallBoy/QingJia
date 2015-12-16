//
//  HCChangePwdRequest.h
//  HealthCloud
//
//  Created by Jessie on 15/10/9.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

@interface HCChangePwdApi : HCRequest

@property (nonatomic, strong) NSString *originalPwd;
@property (nonatomic, strong) NSString *password;

@end
