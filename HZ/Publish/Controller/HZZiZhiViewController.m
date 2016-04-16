//
//  HZZiZhiViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/15.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZZiZhiViewController.h"
#import  "HZCancelTableViewCell.h"
@interface HZZiZhiViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *upTableView;
@property (weak, nonatomic) IBOutlet UITableView *downTableView;
@property (nonatomic, copy) NSArray *qualityList;
@property (nonatomic, strong) NSMutableArray *selectedList;

@end

@implementation HZZiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.upTableView.delegate = self;
    self.upTableView.dataSource = self;
    [self.upTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.upTableV
    
    self.downTableView.delegate = self;
    self.downTableView.dataSource = self;
    [self.downTableView registerNib:[UINib nibWithNibName:@"HZCancelTableViewCell" bundle:nil] forCellReuseIdentifier:@"cancel"];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.upTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
    if (tableView == self.downTableView) {
        HZCancelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cancel"];
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.upTableView) {
        return self.qualityList.count;
    }else{
        return self.selectedList.count;
    }
    return 0;
}

@end
