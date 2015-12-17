//
//  HCHomeImgViewTagList.h
//  Ordering
//
//  Created by 陈福杰 on 15/11/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCImgViewTagListDelegate <NSObject>

- (void)ImgViewTagList:(NSInteger)index;

@end

@interface HCImgViewTagList : UIView

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) id<HCImgViewTagListDelegate>delegate;

@end
