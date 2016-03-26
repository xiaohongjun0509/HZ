//
//  HZEnterpriseCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZEnterpriseCell.h"

@interface HZEnterpriseCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation HZEnterpriseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HZEnterpriseModel *)model{
    self.titleLabel.text = model.company;
    self.addressLabel.text = model.area;
    self.timeLabel.text = model.comtime;
}

@end
