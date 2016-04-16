//
//  HZCancelTableViewCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/16.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZCancelTableViewCell.h"

@implementation HZCancelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delete{
    if (self.deleteBlock) {
        self.deleteBlock(self.index);
    }
}
@end
