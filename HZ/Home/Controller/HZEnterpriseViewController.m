//
//  HZEnterpriseViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZEnterpriseViewController.h"
#import "HZEnterpriseCell.h"
#import "HZEnterpriseModel.h"
#import "MbUserInfo.h"
#import "MbEnterpriseTableViewCell.h"
#import "MbEnterpriseDetailViewController.h"
@interface HZEnterpriseViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation HZEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSearchField];
    [self attachBackButton];
    self.cityName = @"北京市";
    self.title = [NSString stringWithFormat:@"企业通(%@)",self.cityName];
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
//    [self registerCell:[MbEnterpriseTableViewCell class]];
    [self.tableView registerClass:[MbEnterpriseTableViewCell class] forCellReuseIdentifier:@"MbEnterpriseTableViewCell"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addSearchField{
    self.searchField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth-100, 30)];
    self.searchField.placeholder = @"请输入企业资质/公司名称";
    self.searchField.delegate = self;
    [self.searchField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.searchField.textAlignment = NSTextAlignmentCenter;
    [self.searchField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    self.searchField.clearButtonMode = UITextFieldViewModeNever;
    self.searchField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchField];
    
    UILabel* line = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.searchField.frame), ScreenWidth - 100, 1)];
    line.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:line];
    //搜索按钮
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchField.frame)+5, 10, 20, 20)];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"home_4_search.png"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBtn];
    


}


- (void)refreshData{
    self.requestPage = 1;
    [self startRequest];
    
}

-(void)loadMoreData{
    [self startRequest];
}

- (void)startRequest{
        NSURL *url = [NSURL URLWithString:enterpriseList];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str =[NSString stringWithFormat:@"area=%@&hasNext=%ld",self.cityName,self.requestPage];//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (received) {
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
        if (self.requestPage == 1) {
            [self.dataList removeAllObjects];
        }
        NSArray *array = [self paserEnterpriseByDic:dic];
        [self.dataList addObjectsFromArray:array];
        [self.tableView reloadData];
        if (array.count > 1) {
            self.requestPage++;
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    

}

-(NSMutableArray*)paserEnterpriseByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSDictionary* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.address = [dictionary objectForKey:@"address"];
        info.area = [dictionary objectForKey:@"area"];
        info.company = [dictionary objectForKey:@"company"];
        info.companyid = [dictionary objectForKey:@"companyid"];
        info.comtime = [dictionary objectForKey:@"comtime"];
        info.contact = [dictionary objectForKey:@"contact"];
        info.intelligence = [dictionary objectForKey:@"intelligence"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.range = [dictionary objectForKey:@"range"];
        info.tedail = [dictionary objectForKey:@"tedail"];
        [list addObject:info];
    }
    return list;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MbEnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MbEnterpriseTableViewCell"];
    MbUserInfo *model = self.dataList[indexPath.row];
    [cell loadContent:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0f;
    MbEnterpriseTableViewCell *cell = (MbEnterpriseTableViewCell *)[self tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
    cellHeight = cell.finalH;
    
    return cellHeight;
//    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MbEnterpriseDetailViewController *detailVC = [[MbEnterpriseDetailViewController alloc]init];
    MbUserInfo* info = [self.dataList objectAtIndex:indexPath.row];
    detailVC.info = info;
//    [self presentVC:detailVC];
    
}

@end
