//
//  MbZhaoBiaoTableViewCell.h
//  好筑
//
//  Created by tusm on 15/12/10.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MbZhaoBiaoTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* companyLabel;
@property(nonatomic,strong)UILabel* dateLabel;
@property(nonatomic,assign)float finalH;
@property(nonatomic,strong)UIViewController* delegate;
@end
