//
//  HCActivateTagApi.h
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"



typedef void(^HCActivateTagApiBlock)(HCRequestStatus requestStatus, NSString *message, id data);


@interface HCActivateTagApi : HCRequest

- (void)startRequest:(HCActivateTagApiBlock)requestBlock;

@property (nonatomic,strong) NSString *LabelGUID;
@end
