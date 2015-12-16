//
//  HCertificateInfo.m
//  HealthCloud
//
//  Created by Vincent on 15/9/22.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCertificateInfo.h"

@implementation HCertificateInfo

- (id)mutableCopyWithZone:(NSZone *)zone
{
    HCertificateInfo *certificateInfo = [[[self class] allocWithZone:zone] init];
    
    certificateInfo.certificateNo = [_certificateNo mutableCopy];
    certificateInfo.source = [_source mutableCopy];
    certificateInfo.certificateType = [_certificateType mutableCopy];
    certificateInfo.sourceText = [_sourceText mutableCopy];
    certificateInfo.certificateTypeText = [_certificateTypeText mutableCopy];
    
    return certificateInfo;
}

@end
