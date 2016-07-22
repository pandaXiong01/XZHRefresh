//
//  XZHViewController.m
//  MJRefreshExample
//
//  Created by 熊志华 on 16/5/30.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHViewController.h"
#import "XZHRefresh.h"
#import "XZHRefreshView.h"

NSString *const TableViewCellIdentifier = @"cell";

@interface XZHViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XZHRefreshHeaderView *header;
@property (nonatomic, strong) XZHRefreshFooterView *footer;
@property (nonatomic, strong) XZHRefreshView *refreshView;
@end

@implementation XZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    

    
    
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
    //[self addFooter];
    
}
- (void)addFooter
{
//    __unsafe_unretained XZHViewController *vc = self;
//    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
//    footer.scrollView = self.tableView;
//    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
//        // 增加5条假数据
//        for (int i = 0; i<5; i++) {
//            int random = arc4random_uniform(1000000);
//            [vc.dataSource addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
//        }
//        
//        // 模拟延迟加载数据，因此2秒后才调用）
//        // 这里的refreshView其实就是footer
//        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
//        
//        NSLog(@"%@----开始进入刷新状态", refreshView.class);
//    };
//    _footer = footer;
}

- (void)addHeader
{
    self.refreshView = [[XZHRefreshView alloc] init];
    [_refreshView addRefreshTarget:self action:@selector(refreshAction:)];
//    __unsafe_unretained XZHViewController *vc = self;
//    
//    XZHRefreshHeaderView *header = [XZHRefreshHeaderView header];
//    header.scrollView = self.tableView;
//    header.beginRefreshBlock = ^(XZHRefreshBaseView *refreshView) {
//        // 进入刷新状态就会回调这个Block
//        
//        // 增加5条假数据
//        for (int i = 0; i<5; i++) {
//            int random = arc4random_uniform(1000000);
//            [vc.dataSource insertObject:[NSString stringWithFormat:@"随机数据---%d", random] atIndex:0];
//        }
//        
//        // 模拟延迟加载数据，因此2秒后才调用）
//        // 这里的refreshView其实就是header
//        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
//        
//        NSLog(@"%@----开始进入刷新状态", refreshView.class);
//    };
//    header.endRefreshBlock = ^(XZHRefreshBaseView *refreshView) {
//        // 刷新完毕就会回调这个Block
//        NSLog(@"%@----刷新完毕", refreshView.class);
//    };
//    header.stateChangeBlock = ^(XZHRefreshBaseView *refreshView, XZHRefreshState state) {
//        // 控件的刷新状态切换了就会调用这个block
//        switch (state) {
//            case XZHRefreshStateNormal:
//                NSLog(@"%@----切换到：普通状态", refreshView.class);
//                break;
//                
//            case XZHRefreshStatePulling:
//                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
//                break;
//                
//            case XZHRefreshStateRefreshing:
//                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
//                break;
//            default:
//                break;
//        }
//    };
//    [header beginRefresh];
//    _header = header;
}
- (void)doneWithView:(XZHRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.refreshView beginRefreshing];
}
- (void)refreshAction:(XZHRefreshView *)refreshView {

    NSLog(@"开始刷新……");
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
