//
//  HZLocationCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZLocationCell.h"

@interface HZLocationCell()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation HZLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.button addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    self.city = @"北京市";
}


- (void)update{
    if (self.updateCity) {
        self.updateCity(self.city);
    }
}
@end
