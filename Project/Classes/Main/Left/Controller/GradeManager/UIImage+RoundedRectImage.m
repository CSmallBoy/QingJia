//
//  UIImage+RoundedRectImage.m
//  二维码生成(带小图)
//
//  Created by 杨德明 on 16/1/18.
//  Copyright © 2016年 guoxin. All rights reserved.
//

#import "UIImage+RoundedRectImage.h"

@implementation UIImage (RoundedRectImage)
#pragma mark - Private Methods
static void addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
     float fw, fh;
     if (widthOfRadius == 0 || heightOfRadius == 0)
     {
         CGContextAddRect(contextRef, rect);
         return;
     }

     CGContextSaveGState(contextRef);
     CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
     CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
     fw = CGRectGetWidth(rect) / widthOfRadius;
     fh = CGRectGetHeight(rect) / heightOfRadius;

     CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
     CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
     CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
     CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
     CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right

     CGContextClosePath(contextRef);
     CGContextRestoreGState(contextRef);
 }

#pragma mark - Public Methods
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
    int w = size.width;
    int h = size.height;

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);

    CGContextBeginPath(contextRef);
    addRoundedRectToPath(contextRef, rect, radius, radius);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}
@end
