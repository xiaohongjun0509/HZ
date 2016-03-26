//
//  HZJobHuntCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobHuntCell.h"

@interface HZJobHuntCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wageLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HZJobHuntCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HZJobModel *)model{
    self.titleLabel.text = model.title;
    self.addressLabel.text = model.address;
    self.detailTextLabel.text = model.company;
    self.jobLabel.text = model.position;
    self.wageLabel.text = model.wages;
    self.timeLabel.text = @"2015-02-25";
}

+(CGFloat)cellHeight{
    return 93;
}
@end
