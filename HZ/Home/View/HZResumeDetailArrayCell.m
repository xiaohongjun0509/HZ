//
//  HZResumeDetailArrayCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeDetailArrayCell.h"
#import "HZResumeExperienceCell.h"
#import "HZResumeModel.h"

@implementation HZResumeDetailArrayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeExperienceCell" bundle:nil] forCellReuseIdentifier:@"HZResumeExperienceCell"];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)setArray:(NSArray *)array{
    _array = array;
    HZResumeExperienceModel * model = [HZResumeExperienceModel mj_objectWithKeyValues:array[0]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZResumeExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeExperienceCell"];
    if (self.school) {
        cell.model = self.array[indexPath.row];
    }else{
        cell.bussModel = self.array[indexPath.row];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZResumeExperienceCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}




+ (CGFloat)cellHeight:(NSArray *)array{
    return array.count * [HZResumeExperienceCell cellHeight];
}
@end