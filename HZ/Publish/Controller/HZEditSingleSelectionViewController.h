//
//  HZEditSingleSelectionViewController.h
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HZEditResumeItemModel.h"



@interface HZEditSingleSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, assign)  HZEditType type;
@property (nonatomic, strong) HZEditResumeItemModel *item;
@property (nonatomic, copy) void (^updateBlock)();
@end
