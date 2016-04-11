//
//  HCDeleteContactPersonApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
// -------------------删除紧急联系人----------------------

typedef void (^HCDeleteContactPersonBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCDeleteContactPersonApi : HCRequest

@property (nonatomic,strong) NSString *contactorId;

-(void)startRequest:(HCDeleteContactPersonBlock)requestBlock;

@end
