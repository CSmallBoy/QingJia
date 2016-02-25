//
//  HCGradeManagerTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCGradeManagerTableViewCellDelegate <NSObject>

- (void)HCGradeManagerTableViewCellSelectedTag:(NSInteger)tag;

@end

@interface HCGradeManagerTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) id<HCGradeManagerTableViewCellDelegate>delegate;

@end
