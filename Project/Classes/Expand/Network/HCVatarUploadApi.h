//
//  HCVatarUploadApi.h
//  HealthCloud
//
//  Created by Vincent on 15/9/29.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCUploadHeadImageBlock)(HCRequestStatus requestStatus, NSString *message, NSNumber *userAvatar);

@interface HCVatarUploadApi : HCRequest

- (void)startRequest:(HCUploadHeadImageBlock)requestBlock;

@property (nonatomic, strong) UIImage *image;

@end
