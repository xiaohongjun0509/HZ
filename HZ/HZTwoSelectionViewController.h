//
//  HZTwoSelectionViewController.h
//  HZ
//
//  Created by hongjunxiao on 16/4/9.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZTwoSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (nonatomic, copy) NSArray *leftList;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^updateBlock)(NSString *);
@end
