//
//  HCHomePublishApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomePublishApi.h"

@implementation HCHomePublishApi

- (void)startRequest:(HCHomePublishBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    NSString *imagesString = [_FTImages componentsJoinedByString:@","];
    NSString *permitUserString = [_PermitUserArr componentsJoinedByString:@","];
    
    NSDictionary *head = @{@"Action": @"Publish", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *entity = @{@"FamilyID": @([_FamilyID integerValue]),
                             @"FTImages": imagesString,
                             @"FTContent": _FTContent,
                             @"OpenAddress": @([_OpenAddress integerValue]),
                             @"PermitType": _PermitType,
                             @"PermitUserArr": permitUserString,
                             @"CreateLocation": [NSString stringWithFormat:@"%@,%@", [HCAppMgr manager].longitude, [HCAppMgr manager].latitude],
                             @"CreateAddrSmall": [HCAppMgr manager].addressSmall,
                              @"CreateAddr": [HCAppMgr manager].address
                                 };
    NSDictionary *body = @{@"Head": head, @"Entity": entity};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"data"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

//- (AFConstructingBlock)constructingBodyBlock {
//    return ^(id<AFMultipartFormData> formData) {
//        
//        for (NSInteger i = 0; i < self.photoArr.count; i++)
//        {
//            NSString *name = @"file.jpg";
//            NSString *type = @"image/jpeg";
//            NSString *formKey = @"file[]";
//            
//            UIImage *image = self.photoArr[i];
//            DLog(@"image---%@", image);
//            NSData *data = UIImageJPEGRepresentation(image, 0.8);
//            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
//        }
//    };
//}


@end
