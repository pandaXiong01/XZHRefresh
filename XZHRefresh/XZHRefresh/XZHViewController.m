//
//  XZHViewController.m
//  MJRefreshExample
//
//  Created by 熊志华 on 16/5/30.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHViewController.h"
#import "XZHRefresh.h"


NSString *const TableViewCellIdentifier = @"cell";

@interface XZHViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XZHRefreshGeneralHeaderView *header;
@property (nonatomic, strong) XZHRefreshGeneralFooterView *footer;
@end

@implementation XZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(handleStopRefresh)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    // Do any additional setup after loading the view.
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    // 1.注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    
    // 2.初始化假数据
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i<12; i++) {
        int random = arc4random_uniform(1000000);
        [_dataSource addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    [self addHeader];
    
    // 3.2.上拉加载更多
    [self addFooter];
    
}


- (void)addHeader
{
    self.tableView.refreshHeader = [XZHRefreshGeneralHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.tableView.refreshHeader beginRefreshing];
    
    
}
- (void)addFooter
{
    self.tableView.refreshFooter = [XZHRefreshGeneralFooterView footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}
- (void)refreshAction {
    
    
    // 模拟延迟加载数据，因此2秒后才调用）
    [self performSelector:@selector(headerRefreshEndAction) withObject:nil afterDelay:2.0];
}
- (void)refreshLoadMore {
    
    //模拟延迟加载数据，因此2秒后才调用）
    [self performSelector:@selector(footerRefreshEndAction) withObject:nil afterDelay:2.0];
}
- (void)headerRefreshEndAction {
    [self.dataSource removeAllObjects];
    for (int i = 0; i<10; i++) {
        int random = arc4random_uniform(1000000);
        [self.dataSource insertObject:[NSString stringWithFormat:@"随机数据---%d", random] atIndex:0];
    }
    [self.tableView.refreshHeader endRefreshing];
    [self.tableView reloadData];
}
- (void)footerRefreshEndAction {
    // 增加5条假数据
    
    for (int i = 0; i<5; i++) {
        int random = arc4random_uniform(1000000);
        [self.dataSource addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
    
    [self.tableView.refreshFooter endRefreshing];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
    /*上拉加载后 下拉刷新 --  数据越界崩溃
     */
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}
- (void)handleStopRefresh {
    [self.tableView.refreshHeader endRefreshing];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
