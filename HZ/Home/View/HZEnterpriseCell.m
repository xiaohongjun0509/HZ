//
//  HZEnterpriseCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZEnterpriseCell.h"
#import "NSDate+YYAdd.h"
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
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.comtime.integerValue];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt  setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [fmt stringFromDate:date];

    self.timeLabel.text = time;
}

@end
