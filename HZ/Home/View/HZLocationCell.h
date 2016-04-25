//
//  HZLocationCell.h
//  HZ
//
//  Created by hongjunxiao on 16/4/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLocationCell : UITableViewCell
@property (nonatomic, copy) void (^updateCity)(NSString *);
@property (nonatomic, copy) NSString *city;
@end
