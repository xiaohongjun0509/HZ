//
//  HZZiZhiViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/15.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZZiZhiViewController.h"
#import  "HZCancelTableViewCell.h"
#import "HZZiZhiModel.h"
@interface HZZiZhiViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *upTableView;
@property (weak, nonatomic) IBOutlet UITableView *downTableView;
@property (nonatomic, copy) NSArray *qualityList;
@property (nonatomic, strong) NSMutableArray *selectedList;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation HZZiZhiViewController
- (IBAction)add:(id)sender {
    if (self.textfield.text.length > 0) {
        HZZiZhiModel *model = [HZZiZhiModel new];
        model.aptitude = self.textfield.text;
        [self.selectedList addObject:model];
        self.textfield.text = @"";
        self.textfield.delegate = self;
        [self.downTableView reloadData];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资质详情";
    [self.view bringSubviewToFront:self.containView];
    self.upTableView.delegate = self;
    self.upTableView.dataSource = self;
    
    [self.upTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.selectedList = [NSMutableArray array];
    self.downTableView.delegate = self;
    self.downTableView.dataSource = self;
    [self.downTableView registerNib:[UINib nibWithNibName:@"HZCancelTableViewCell" bundle:nil] forCellReuseIdentifier:@"cancel"];
    
    [[NetworkManager manager] postRequest:zizhiUrl parameters:@{@"g":@"all"} completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = responseObject;
        self.qualityList = [HZZiZhiModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.upTableView reloadData];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.upTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        HZZiZhiModel *model = self.qualityList[indexPath.row];
        cell.textLabel.text = model.aptitude;
        return cell;
    }
    if (tableView == self.downTableView) {
        HZCancelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cancel"];
        cell.index = indexPath.row;
        cell.deleteBlock = ^(NSInteger index){
            [self.selectedList removeObjectAtIndex:index];
            [self.downTableView reloadData];
        };
        HZZiZhiModel *model = self.selectedList[indexPath.row];
        cell.contentLabel.text = model.aptitude;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.upTableView == tableView) {
        HZZiZhiModel *model = self.qualityList[indexPath.row];
        if(![self.selectedList containsObject:model]){
            [self.selectedList addObject:model];
            [self.downTableView reloadData];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.selectedList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HZZiZhiModel *model = obj;
        [self.buttonTitles addObject:model.aptitude];
    }];

}
@end
