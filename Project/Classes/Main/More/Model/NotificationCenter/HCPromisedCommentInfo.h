//
//  HCPromisedCommentInfo.h
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCPromisedCommentInfo : NSObject

/**
 *  头像地址
 */
@property (nonatomic,strong) NSString  *image;
/**
 *  用户昵称
 */
@property (nonatomic,strong) NSString  *nickName;
/**
 *  发布时间
 */
@property (nonatomic,strong) NSString  *time;
/**
 *  评论内容
 */
@property (nonatomic,strong) NSString  *comment;
/**
 *  图片数组
 */
@property (nonatomic,strong) NSArray   *imageArr;


@end
