//
//  HCHomePictureDetailApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCHomePictureDetailBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCHomePictureDetailApi : HCRequest

- (void)startRequest:(HCHomePictureDetailBlock)requestBlock;

@end
