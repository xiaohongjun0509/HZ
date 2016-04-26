//
//  MbEnterpriseViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/26.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbEnterpriseViewController.h"

#import "MbEnterpriseTableViewCell.h"
#import "MbEnterpriseDetailViewController.h"
#import "MJRefresh.h"
@interface MbEnterpriseViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)UITextField* searchField;
@property(nonatomic,strong)UITableViewHeaderFooterView* hf;
@property(nonatomic,strong)MbEnterpriseDetailViewController* detailVC;  //企业通详情
@property(nonatomic,strong)UIButton* searchBtn;     //搜索按钮
@property(nonatomic,strong)NSMutableArray* lists;
@property(nonatomic,assign)int freshCount;
@property(nonatomic,strong)NSDictionary* dictionary;  //
@property(nonatomic,strong)UIActivityIndicatorView* activity;
@end

@implementation MbEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self attachBackButton];
    self.freshCount=2;
    self.title = @"企业通";
    self.view.backgroundColor = [UIColor whiteColor];
    self.lists = [NSMutableArray array];
    self.dictionary = [[NSDictionary alloc]init];
    //搜索
    self.searchField = [[UITextField alloc]initWithFrame:CGRectMake(50, 10, viewWidth-100, 30)];
    self.searchField.placeholder = @"请输入企业资质/公司名称";
    self.searchField.delegate = self;
    [self.searchField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
      self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.searchField.textAlignment = NSTextAlignmentCenter;
    [self.searchField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
     self.searchField.clearButtonMode = UITextFieldViewModeNever;
    self.searchField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];

    [self.view addSubview:self.searchField];
    //横线
    
    UILabel* line = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.searchField.frame), viewWidth - 100, 1)];
    line.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:line];
    //搜索按钮
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchField.frame)+5, 15, 20, 20)];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"home_4_search.png"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBtn];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, viewWidth, viewHeight-50-64)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MbEnterpriseTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai)];
    [self.tableView.mj_header beginRefreshing];
   
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}


-(void)freshDongtai{
    self.freshCount = 1;
    [self startRequest];
}
-(void)moreDongtai{
    [self startRequest];
}
-(void)startRequest{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
        NSString* path = [NSString stringWithFormat:@"%@?area=%@&hasNext=%@",enterpriseList,self.cityName,@(self.freshCount).stringValue];
        NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str =[NSString stringWithFormat:@"area=%@&hasNext=%d",self.cityName,self.freshCount];//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (received) {
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
        NSArray* array = [dic objectForKey:@"data"];
        if (array.count==0) {
            self.lists = [MbPaser paserEnterpriseByDic:self.dictionary];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            self.freshCount++;
            self.lists = [MbPaser paserEnterpriseByDic:dic];
            self.dictionary = dic;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }
}
    








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lists.count;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MbEnterpriseTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    MbUserInfo* info = [self.lists objectAtIndex:indexPath.row];
    [cell loadContent:info];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailVC = [[MbEnterpriseDetailViewController alloc]init];
    MbUserInfo* info = [self.lists objectAtIndex:indexPath.row];
    self.detailVC.info = info;
    
    [self presentVC:self.detailVC];

}




-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.backgroundColor = [UIColor whiteColor];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

//搜索
-(void)search:(UIButton*)sender{

    NSString* path = [NSString stringWithFormat:@"%@?area=%@&company=%@",enterpriseList,self.cityName,self.searchField.text];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    //NSString *str =[NSString stringWithFormat:@"area=%@",self.cityName];//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    if (dic) {
        [self.activity stopAnimating];
        [self.activity hidesWhenStopped];
    }
    self.dictionary = dic;
    self.lists = [MbPaser paserEnterpriseByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    


}
//
-(void)textFieldChanged:(UITextField*)textTield{
    if (textTield.text.length==0) {
        [self freshDongtai];
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self.searchField resignFirstResponder];

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
