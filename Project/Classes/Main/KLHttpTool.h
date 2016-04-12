//
//  WBHttpTool.h
//  XinWeibo
//  AFN封装接口
//  Created by tanyang on 14/10/19.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLHttpTool : NSObject
//上传图片
/**
 *  发送一个post请求上传图片
 *
 *  @param url     请求路径
 *  @param params  图片
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)uploadImageWithUrl:(NSString *)url
                    image:(UIImage *)image
                  success:(void(^)(id responseObject))success
                  failure:(void(^)(NSError *error))failure;
@end

/**
 *  用来封装文件数据的模型
 */
@interface WBFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
