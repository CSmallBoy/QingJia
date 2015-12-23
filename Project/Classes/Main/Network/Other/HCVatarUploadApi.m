//
//  HCVatarUploadApi.m
//  HealthCloud
//
//  Created by Vincent on 15/9/29.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCVatarUploadApi.h"

@implementation HCVatarUploadApi

- (void)startRequest:(HCUploadHeadImageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = @"头像上传失败";
    
    switch (statusCode) {
        case HCRequestStatusSuccess:
            msg = @"头像上传成功";
            break;
        default:
            break;
    }
    
    return msg;
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"data"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    if (IsEmpty(self.Argument))
    {
        return @{@"t": @"User,logout", @"token": @"23"};
    }
    return self.Argument;
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.3);
        
        NSString *name = @"file.jpg";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}


@end
