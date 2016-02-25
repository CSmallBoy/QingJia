//
//  UIImage+RoundedRectImage.h
//  二维码生成(带小图)
//
//  Created by 杨德明 on 16/1/18.
//  Copyright © 2016年 guoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedRectImage)

+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;


@end
