//
//  HCTableViewController.h
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCViewController.h"

@interface HCTableViewController : HCViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
