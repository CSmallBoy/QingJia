//
//  HCPromisedListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/1/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCPrromisedListBlock) (HCRequestStatus  requestStatus,NSString *message,id reponseObjectf);


@interface HCPromisedListApi : HCRequest

@property(nonatomic,strong)NSString  *Token;

-(void)startRequest:(HCPrromisedListBlock)requestBlock;


@end
