//
//  HCPromisedListInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface HCPromisedListInfo : HCRequest
/**
 *  姓名
 */
@property(nonatomic,copy)NSString  *name;
/**
 *  ID
 */
@property(nonatomic,copy)NSNumber * ObjectId;
/**
 *  按钮的颜色
 */
@property(nonatomic,assign) BOOL  isBlack;
/**
 *  是否发送过
 */
@property(nonatomic,assign) BOOL  isSend;
@end
