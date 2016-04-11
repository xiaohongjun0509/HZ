//
//  HZEditEducationCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZEditEducationCell.h"
#import "HZStudyDetailCell.h"
@interface HZEditEducationCell ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HZEditEducationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HZStudyDetailCell" bundle:nil] forCellReuseIdentifier:@"HZStudyDetailCell"];
    [self.button addTarget:self action:@selector(gotoJump) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)gotoJump{
    if (self.editBlock) {
        self.editBlock();
    }
}
+ (CGFloat)cellHeight:(NSArray *)array{
    if (array.count > 0) {
        return array.count * 128 + 44;
    }
    return  44;
}


- (void)setModel:(HZEditResumeItemModel *)model{
    _model = model;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.study){
        HZStudyDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZStudyDetailCell"];
        cell.isStudy = self.study;
        cell.model = self.model.studyList[indexPath.row];
        return cell;
    }else{
        HZStudyDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZStudyDetailCell"];
        cell.isStudy = self.study;
        cell.model = self.model.workList[indexPath.row];
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.study ? self.model.studyList.count : self.model.workList.count;
}

@end
