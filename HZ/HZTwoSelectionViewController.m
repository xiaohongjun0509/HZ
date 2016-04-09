//
//  HZTwoSelectionViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/9.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZTwoSelectionViewController.h"
#import "HZLeftTableViewCell.h"
#import "HZPositionTypeModel.h"
#import "HZPositionName.h"
#import "HZRightTableViewCell.h"
@interface HZTwoSelectionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, copy) NSArray *rightList;

@end

@implementation HZTwoSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftList = [NSArray array];
    self.rightList = [NSMutableArray array];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 60;
    self.rightTableView.rowHeight = 60;
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate = self;
    
    [self.leftTableView registerNib:[UINib nibWithNibName:@"HZLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"HZLeftTableViewCell"];
    [self.rightTableView registerNib:[UINib nibWithNibName:@"HZRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"HZRightTableViewCell"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideController)];
    [self.view addGestureRecognizer:tap];

}


- (void)hideController{
    self.view.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leftTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rightTableView == tableView) {
        HZRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZRightTableViewCell"];
        HZPositionName *model = self.rightList[indexPath.row];
        cell.label.text = model.positioname;
        return cell;
    }
    if (self.leftTableView == tableView) {
        HZLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZLeftTableViewCell"];
        HZPositionTypeModel *model = self.leftList[indexPath.row];
        cell.label.text = model.positioname;
        return cell;
    }
    return nil;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.rightTableView == tableView) {
        return self.rightList.count;
    }
    if (self.leftTableView == tableView) {
        return self.leftList.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.leftTableView == tableView) {
        [self setSelectedIndex:indexPath.row];
    }else{
        if (self.updateBlock) {
           HZPositionName *nameModel = self.rightList[indexPath.row];
            self.updateBlock(nameModel.positioname);
            self.view.hidden = YES;
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    HZPositionTypeModel *model = self.leftList[selectedIndex];

    self.rightList = model.position;
    [self.rightTableView reloadData];
}
@end
