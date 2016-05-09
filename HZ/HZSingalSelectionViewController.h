//
//  HZSingalSelectionViewController.h
//  HZ
//
//  Created by hongjunxiao on 16/4/9.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HZSingleType){
    HZSingleTypeUnkown,
    HZSingleTypeArea,//区域
    HZSingleTypeWage,//工资
    HZSingleTypeSuffer//工作年限
};

@interface HZSingalSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, copy) void (^updateBlock)(NSString *);
@property (nonatomic, assign) HZSingleType singleType;
@end
