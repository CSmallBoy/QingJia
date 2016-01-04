//
//  HCApplyReissueResonApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReissueResonApi.h"

@implementation HCApplyReissueResonApi


- (void)startRequest:(HCApplyReissueResonBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{};
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
