//
//  HZSegmentView.h
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZSegmentView : UIView
@property (nonatomic, strong) UIButton *positionBtn;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIButton *salaryBtn;
@property (nonatomic, strong) UILabel *salarLabel;

@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, copy) void (^positionBlock)(void);
@property (nonatomic, copy) void (^locationBlock)(void);
@property (nonatomic, copy) void (^salaryBlock)(void);



- (void)hiddenAllArrors;

- (void)setSelectedColor:(UIColor *)color;
@end
