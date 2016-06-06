//
//  HCSavePhotoToAblumMgr.h
//  钦家
//
//  Created by Tony on 16/6/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface HCSavePhotoToAblumMgr : NSObject

/**
 *  创建单利
 */
+ (HCSavePhotoToAblumMgr *)shareManager;

/**
 *  保存图片到自定义相册
 *
 *  @param image 需要保存的图片
 *
 *  @return 提示信息(保存成功/失败)
 */
- (NSString *)saveImageToAblum:(UIImage *)image;


@end
