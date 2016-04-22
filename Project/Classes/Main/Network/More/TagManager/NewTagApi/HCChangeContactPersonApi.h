//
//  HCChangeContactPersonApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------变更紧急联系人----------------------

typedef void (^HCChangeContactPersonBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCChangeContactPersonApi : HCRequest

@property (nonatomic,strong) NSString *contactorId;
@property (nonatomic,strong) NSString *phoneNo;
@property (nonatomic,strong) NSString *imageName;

-(void)startRequest:(HCChangeContactPersonBlock)requestBlock;

@end
