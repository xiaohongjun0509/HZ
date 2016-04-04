//
//  MbNewsTableViewCell.h
//  好筑
//
//  Created by tusm on 16/2/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZNewsTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* titleLabel;       //标题
@property(nonatomic,strong)UIImageView* image;        //图片


+ (CGFloat)cellHeight;

@end
