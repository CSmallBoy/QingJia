//
//  HCImageUploadApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCImageUploadApi.h"
#import "HCImageUploadInfo.h"

@implementation HCImageUploadApi

- (void)startRequest:(HCImageUploadBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"ImgUpload.ashx?fileType=%@", _fileType];
}

- (BOOL)useCDN
{
    return YES;
}

- (id)formatResponseObject:(id)responseObject
{
    NSArray *array = responseObject[@"Data"][@"files"];
    return [HCImageUploadInfo mj_objectArrayWithKeyValuesArray:array];
    return responseObject[@"Data"];
}

- (AFConstructingBlock)constructingBodyBlock
{
    return ^(id<AFMultipartFormData> formData)
    {
        for (NSInteger i = 0; i < self.FTImages.count; i++)
        {
            NSString *name = @"file.jpg";
            NSString *type = @"image/jpeg";
            NSString *formKey = @"file[]";
            
            UIImage *image = self.FTImages[i];
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        }
    };
}



@end
