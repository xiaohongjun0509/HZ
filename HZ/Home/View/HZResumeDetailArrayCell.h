//
//  HZResumeDetailArrayCell.h
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZResumeDetailArrayCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, assign) BOOL school;
+ (CGFloat)cellHeight:(NSArray *)array;
@end
