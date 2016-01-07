//
//  HCPromisedHeaderIVCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCLightGrayLineView.h"

typedef void(^selectImagBlock) (void);

@interface HCPromisedHeaderIVCell : UITableViewCell

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)selectImagBlock  selectImageblock;
@property(nonatomic,assign)BOOL   isBlack;

+(instancetype)CustomCellWithTableView:(UITableView *)tableView;


@end
