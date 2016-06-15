//
//  GetAllFamily.h
//  钦家
//
//  Created by 殷易辰 on 16/6/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
// ------------------信息中心列表--------------------------
typedef void(^HCAllFamilyBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface GetAllFamily : HCRequest

-(void)startRequest:(HCAllFamilyBlock)requestBlock;

@end
