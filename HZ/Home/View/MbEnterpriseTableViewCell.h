//
//  MbEnterpriseTableViewCell.h
//  Recruitment
//
//  Created by tusm on 15/11/2.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JZQCommon.h"
#import "MbUserInfo.h"
@interface MbEnterpriseTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* nameLabel;    //公司名称
@property(nonatomic,strong)UILabel* placeLabel;   //地区
@property(nonatomic,strong)UILabel* dateLabel;    //日期
@property(nonatomic,strong)UIButton* btn;         //循环按钮
@property(nonatomic,strong)NSArray* array;
@property (nonatomic, readonly) CGFloat finalH;

- (void)loadContent:(MbUserInfo*)data;

@end
