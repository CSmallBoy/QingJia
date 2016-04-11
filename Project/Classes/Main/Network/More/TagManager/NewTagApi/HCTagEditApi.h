//
//  HCTagEditApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------编辑标签----------------------

typedef void (^HCTagEditBlock) (HCRequestStatus  requestStatus,NSString *message,id reponse);

@interface HCTagEditApi : HCRequest


@property (nonatomic,strong) NSString *labelId;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *contactorId1;
@property (nonatomic,strong) NSString *contactorId2;

-(void)startRequest:(HCTagEditBlock)requestBlock;

@end
