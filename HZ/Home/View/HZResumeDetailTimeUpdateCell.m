//
//  HZResumeDetailTimeUpdateCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/16.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeDetailTimeUpdateCell.h"

@implementation HZResumeDetailTimeUpdateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zhaoTypeButton.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
