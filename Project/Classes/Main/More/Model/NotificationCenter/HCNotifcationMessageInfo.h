//
//  HCNotifcationMessageInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNotifcationMessageInfo : NSObject

/**
 *  图片网址
 */
@property (nonatomic,copy)NSString * image;

/**
 *  给谁的留言
 */
@property (nonatomic,strong) NSString  *title;
/**
 *  留言内容
 */
@property(nonatomic,strong) NSString  *message;
/**
 *  留言时间
 */
@property (nonatomic,strong) NSString  * time;

@property(nonatomic,assign) BOOL  isCall;

@end
