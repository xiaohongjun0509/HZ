//
//  TableBaseViewController.h
//  HZ
//
//  Created by hongjunxiao on 16/3/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableBaseViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger requestPage;
-(void)setTopInset:(CGFloat)top;

- (void)loadMoreData;


- (void)refreshData;

- (void)registerCell:(Class)clz;
@end
