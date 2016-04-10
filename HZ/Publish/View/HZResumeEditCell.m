//
//  HZResumeEditCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeEditCell.h"



@interface HZResumeEditCell ()
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation HZResumeEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.button addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setModel:(HZEditResumeItemModel *)model{
    _model = model;
    self.title.text = model.leftTitle;
    self.placeHolderLabel.text  =model.placeHolder;
    if (model.btnTitle.length > 0) {
        self.placeHolderLabel.hidden = YES;
    }else{
        self.placeHolderLabel.hidden = NO;
    }
    if (model.btnTitle.length) {
        [self.button setTitle:model.btnTitle forState:UIControlStateNormal];
        self.button.hidden = NO;
    }else{
        self.button.hidden = NO;
        [self.button setTitle:@"" forState:UIControlStateNormal];
    }
}


- (void)select{
    if (self.showSelectionView) {
        self.showSelectionView(_model.index - 1000 - 2);
    }
}
@end
