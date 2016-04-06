//
//  NHCUserHeathApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface NHCUserHeathApi : HCRequest
@property (nonatomic,copy) NSString *height;
@property (nonatomic,copy) NSString *weight ;
@property (nonatomic,copy) NSString *bloodType;
@property (nonatomic,copy) NSString *allergic;
@property (nonatomic,copy) NSString *cureCondition;
@property (nonatomic,copy) NSString *cureNote;
@end
