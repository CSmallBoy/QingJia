//
//  HCShowMoreImage.h
//  Project
//
//  Created by 陈福杰 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCHomeMoreImgViewDelegate <NSObject>

- (void)hchomeMoreImgView:(NSInteger)index;

@end

@interface HCShowMoreImage : UIView

@property (nonatomic, strong) NSArray *imageUrlArr;

@property (nonatomic, weak) id<HCHomeMoreImgViewDelegate>delegate;

@end
