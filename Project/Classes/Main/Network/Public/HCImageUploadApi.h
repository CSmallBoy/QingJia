//
//  HCImageUploadApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCImageUploadBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCImageUploadApi : HCRequest

@property (nonatomic, strong) NSString *fileType;

@property (nonatomic, strong) NSArray *FTImages;

- (void)startRequest:(HCImageUploadBlock)requestBlock;

@end
