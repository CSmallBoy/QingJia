//
//  WBHttpTool.m
//  XinWeibo
//  AFN封装接口
//  Created by tanyang on 14/10/19.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLHttpTool.h"
#import "AFNetworking.h"

@implementation KLHttpTool

//上传图片
+(void)uploadImageWithUrl:(NSString *)url
                        image:(UIImage *)image
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"eeror ==  %@",error.debugDescription);
    }];
}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation WBFormData

@end