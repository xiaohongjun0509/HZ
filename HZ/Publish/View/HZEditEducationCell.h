//
//  HZEditEducationCell.h
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZEditResumeItemModel.h"
@interface HZEditEducationCell : UITableViewCell

+ (CGFloat)cellHeight:(NSArray *)array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HZEditResumeItemModel *model;
@property (nonatomic, assign) BOOL study;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy) void (^editBlock)(void);
@end
