//
//  HCTimePushListInfo.h
//  钦家
//
//  Created by Tony on 16/6/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCTimePushListInfo : NSObject

@property (nonatomic, copy)NSString *type;//推送类型  0为时光评论,1为单图评论,2为点赞
@property (nonatomic, copy)NSString *timesId;//时光id
@property (nonatomic, copy)NSString *contentText;//时光内容
@property (nonatomic, copy)NSString *contentImageName;//时光的图片
@property (nonatomic, copy)NSString *creator;//评论者的id
@property (nonatomic, copy)NSString *nickName;//评论者的昵称
@property (nonatomic, copy)NSString *imageName;//评论者的头像
@property (nonatomic, copy)NSString *cText;//评论内容
@property (nonatomic, copy)NSString *cImageName;//评论图片
@property (nonatomic, copy)NSString *createTime;//评论时间

@end
