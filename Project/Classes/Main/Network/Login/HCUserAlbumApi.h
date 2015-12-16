//
//  HCUserAlbumApi.h
//  Project
//
//  Created by 陈福杰 on 15/11/26.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCUserAlbumBlock)(HCRequestStatus requestStatus, NSString *message, NSMutableArray *array);

@interface HCUserAlbumApi : HCRequest

@property (nonatomic, strong) NSArray *bodyArr;

- (void)startRequest:(HCUserAlbumBlock)requestBlock;

@end
