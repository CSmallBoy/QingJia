//
//  NHCHomeClickPushListApi.h
//  钦家
//
//  Created by Tony on 16/6/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^NHCHomeClickPushListBlock)(HCRequestStatus requestStatus, NSString *message, id responseObject);

@interface NHCHomeClickPushListApi : HCRequest

@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *timesId;
@property (nonatomic,copy) NSString *contentImageName;

- (void)startRequest:(NHCHomeClickPushListBlock)requestBlock;

@end
