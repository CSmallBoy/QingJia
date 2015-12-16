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
    NSDictionary *dict = [responseObject objectForKey:@"record"];
    NSNumber *userAvatar = [dict objectForKey:@"fileId"];
    return userAvatar;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"X-Access-Token":[HCAccountMgr manager].loginInfo.accessToken};
}

- (NSString *)requestUrl
{
    return @"upload";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        NSData *data = UIImageJPEGRepresentation(self.image, 0.5);
        NSString *fileName = @"avatar.jpg";
        NSString *name = @"upload";
        NSString *mimeType = @"image/jpeg";
        NSString *catalog = @"avatar";
        NSString *path = @"avatar";
        NSString *mode = @"31";

        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
        NSMutableDictionary *catalogHeaders = [NSMutableDictionary dictionary];
        NSString *catalogDisposition = [NSString stringWithFormat:@"form-data; name=\"catalog\""];
        [catalogHeaders setValue:catalogDisposition forKey:@"Content-Disposition"];
        NSData *catalogData = [catalog dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithHeaders:catalogHeaders body:catalogData];
        
        NSMutableDictionary *pathHeaders = [NSMutableDictionary dictionary];
        NSString *pathDisposition = [NSString stringWithFormat:@"form-data; name=\"path\""];
        [pathHeaders setValue:pathDisposition forKey:@"Content-Disposition"];
        NSData *pathData = [path dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithHeaders:pathHeaders body:pathData];
        
        NSMutableDictionary *modeHeaders = [NSMutableDictionary dictionary];
        NSString *modeDisposition = [NSString stringWithFormat:@"form-data; name=\"mode\""];
        [modeHeaders setValue:modeDisposition forKey:@"Content-Disposition"];
        NSData *modeData = [mode dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithHeaders:modeHeaders body:modeData];
        
    };
}


@end
