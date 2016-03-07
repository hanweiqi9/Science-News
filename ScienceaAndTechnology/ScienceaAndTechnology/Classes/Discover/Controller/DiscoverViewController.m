//
//  DiscoverViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "DiscoverViewController.h"
#import "PullingRefreshTableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DiscoverTableViewCell.h"
#import "DiscoverModel.h"
#import "HWTools.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LineViewController.h"

@interface DiscoverViewController ()<PullingRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,strong) NSMutableArray *detailsArray;//详情
@property(nonatomic,strong) NSMutableArray *topArray;//大图
@property(nonatomic,strong) NSMutableArray *TitleArray;//标题
@property(nonatomic,strong) NSMutableArray *photoArray;
@property(nonatomic,strong) NSMutableArray *subArray;//副标题
@property(nonatomic,strong) NSMutableArray *allArray;
@property(nonatomic,assign) BOOL refreshing;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self requestLoad];
    [self.view addSubview:self.tableView];
    [self.tableView launchRefreshing];
    

}
#pragma mark------------Lazy

-(NSMutableArray *)detailsArray{
    if (_detailsArray == nil) {
        self.detailsArray = [NSMutableArray new];
    }
    return _detailsArray;
}

-(NSMutableArray *)topArray{
    if (_topArray == nil) {
        self.topArray = [NSMutableArray new];
    }
    return _topArray;
}

-(NSMutableArray *)photoArray{
    if (_photoArray == nil) {
        self.photoArray = [NSMutableArray new];
    }
    return _photoArray;
}

-(NSMutableArray *)TitleArray{
    if (_TitleArray == nil) {
        self.TitleArray = [NSMutableArray new];
    }
    return _TitleArray;
}
-(NSMutableArray *)subArray{
    if (_subArray == nil) {
        self.subArray = [NSMutableArray new];
    }
    return _subArray;
}

-(NSMutableArray *)allArray{
    if (_allArray == nil) {
        self.allArray = [NSMutableArray new];
    }
    return _allArray;
}
-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 85;
        self.tableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}


#pragma mark--------------Custom

-(void)requestLoad{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:kFinancial parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *artArray = dic[@"articletag"];
        for (NSDictionary *dict in artArray) {
            NSArray *arr = dict[@"article"];
            for (NSDictionary *dicm in arr) {
                [self.TitleArray addObject:dicm[@"title"]];//标题
//                NSLog(@"han = %@",self.TitleArray);
                [self.subArray addObject:dicm[@"desc"]];
                NSArray *arra = dicm[@"phonepagelist"];
                NSArray *arra1 = dicm[@"picture"];
                NSArray *arra2 = dicm[@"thumb"];
                for (NSDictionary *dicme in arra) {
                    [self.detailsArray addObject:dicme[@"url"]];//详情
                }
                for (NSDictionary *dicme1 in arra1) {
                    [self.topArray addObject:dicme1[@"url"]];//大图片
                }
                
                for (NSDictionary *dicme2 in arra2) {
                    [self.photoArray addObject:dicme2[@"url"]];//图片
//                    NSLog(@"photo = %@",self.photoArray);
                }
            }
        }
//        [self selectBtn];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark-------------UITableViewDelegate
#pragma mark-------------UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.TitleArray[indexPath.row];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:self.photoArray[indexPath.row]] placeholderImage:nil];
    cell.subLabel.text = self.subArray[indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LineViewController *lineVC = [[LineViewController alloc] init];
    UINavigationController *LineNV =[[UINavigationController alloc] initWithRootViewController:lineVC];
    lineVC.urlStr = self.detailsArray[indexPath.row];
    [self.navigationController presentViewController:LineNV animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TitleArray.count ;
}

#pragma mark----------PullingRefreshTableViewDelegate

//下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(requestLoad) withObject:nil afterDelay:1.0];
}
//上拉
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    [self performSelector:@selector(requestLoad) withObject:nil afterDelay:1.0];
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTools getSystemNowDate];
}
//手指拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}
//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    
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
