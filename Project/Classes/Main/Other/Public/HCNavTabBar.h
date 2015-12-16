//
//  PMNavTabBar.h
//  PMedical
//
//  Created by Vincent on 15/6/23.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DOT_COORDINATE                  0.0f
#define STATUS_BAR_HEIGHT               20.0f
#define BAR_ITEM_WIDTH_HEIGHT           30.0f
#define NAVIGATION_BAR_HEIGHT           44.0f
#define TAB_TAB_HEIGHT                  49.0f
#define TAB_LINE_WIDTH                  80.f
#define TABLE_VIEW_ROW_HEIGHT           NAVIGATION_BAR_HEIGHT
#define CONTENT_VIEW_HEIGHT_NO_TAB_BAR  (Main_Screen_Height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)
#define CONTENT_VIEW_HEIGHT_TAB_BAR     (CONTENT_VIEW_HEIGHT_NO_TAB_BAR - TAB_TAB_HEIGHT)

#define ARROW_BUTTON_WIDTH              NAVIGATION_BAR_HEIGHT
#define NAV_TAB_BAR_HEIGHT              ARROW_BUTTON_WIDTH
#define ITEM_HEIGHT                     NAV_TAB_BAR_HEIGHT

#define NavTabbarColor                  UIColorWithRGBA(240.0f, 230.0f, 230.0f, 1.0f)

@protocol HCNavTabBarDelegate <NSObject>

@optional
/**
 *  When NavTabBar Item Is Pressed Call Back
 *
 *  @param index - pressed item's index
 */
- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end

@interface HCNavTabBar : UIView

@property (nonatomic, weak)     id          <HCNavTabBarDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray     *itemTitles;                // all items' title

@property (nonatomic, strong)   UIColor     *lineColor;                 // set the underscore color

/**
 *  Initialize Methods
 *
 *  @param frame - SCNavTabBar frame
 *  @param show  - is show Arrow Button
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame showItemTitles:(NSArray *)titles;

@end
