//
//  HCTagDeleteObjectApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
// -------------------删除对象----------------------
typedef void (^HCTagDeleteObjectBlock) (HCRequestStatus requestStaus,NSString *message,id respone);

@interface HCTagDeleteObjectApi : HCRequest

@property (nonatomic,strong) NSString *objectId;

-(void)startRequest:(HCTagDeleteObjectBlock)requestBlock;

@end
