//
//  MainViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "MainViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "NewsTableViewCell.h"
#import "HWTools.h"
#import "VOSegmentedControl.h"
#import "PullingRefreshTableView.h"
#import "ViewController.h"
#import "ProgressHUD.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,UIScrollViewDelegate>
{
    NSInteger _timeStamp;
    NSInteger _type;
   
}


@property(nonatomic,strong) VOSegmentedControl *segmentedControl;
@property(nonatomic,strong) NSMutableArray *allNewsArray;
@property(nonatomic,strong) NSMutableArray *OneNewsArray;
@property(nonatomic,strong) NSMutableArray *TwoNewsArray;
@property(nonatomic,strong) NSMutableArray *ThreeNewsArray;
@property(nonatomic,strong) NSMutableArray *FourNewsArray;
@property(nonatomic,strong) NSMutableArray *FiveNewsArray;
@property(nonatomic,strong) NSMutableArray *SixNewsArray;
@property(nonatomic,strong) NSMutableArray *homeNewsArray;
@property(nonatomic,strong) PullingRefreshTableView *mainTableView;
@property(nonatomic,strong) UISwipeGestureRecognizer *leftSwipe;
@property(nonatomic,strong) UISwipeGestureRecognizer *rightSwipe;
@property(nonatomic,assign) BOOL refreshing;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.segmentedControl];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _timeStamp = [HWTools getTimesTamp];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self selectBtn];
    [self.mainTableView launchRefreshing];
    [self segmentCtrlValuechange];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [ProgressHUD dismiss];
}

#pragma mark------------Lazy

- (NSMutableArray *)allNewsArray{
    if (_allNewsArray == nil) {
        self.allNewsArray = [NSMutableArray new];
    }
    return _allNewsArray;
}

-(NSMutableArray *)OneNewsArray{
    if (_OneNewsArray == nil) {
        self.OneNewsArray = [NSMutableArray new];
    }
    return _OneNewsArray;
}

-(NSMutableArray *)TwoNewsArray{
    if (_TwoNewsArray == nil) {
        self.TwoNewsArray = [NSMutableArray new];
    }
    return _TwoNewsArray;
}

-(NSMutableArray *)ThreeNewsArray{
    if (_ThreeNewsArray == nil) {
        self.ThreeNewsArray = [NSMutableArray new];
    }
    return _ThreeNewsArray;
}

-(NSMutableArray *)FourNewsArray{
    if (_FourNewsArray == nil) {
        self.FourNewsArray = [NSMutableArray new];
    }
    return _FourNewsArray;
}

-(NSMutableArray *)FiveNewsArray{
    if (_FiveNewsArray == nil) {
        self.FiveNewsArray = [NSMutableArray new];
    }
    return _FiveNewsArray;
}

-(NSMutableArray *)SixNewsArray{
    if (_SixNewsArray == nil) {
        self.SixNewsArray = [NSMutableArray new];
    }
    return _SixNewsArray;
}

-(NSMutableArray *)homeNewsArray{
    if (_homeNewsArray == nil) {
        self.homeNewsArray = [NSMutableArray new];
    }
    return _homeNewsArray;
}

-(VOSegmentedControl *)segmentedControl{
    if (_segmentedControl == nil) {
        self.segmentedControl = [[VOSegmentedControl alloc]initWithSegments:@[@{VOSegmentText:@"最新"},@{VOSegmentText:@"业界"},@{VOSegmentText:@"看点"},@{VOSegmentText:@"深度"},@{VOSegmentText:@"运营"},@{VOSegmentText:@"产品"},@{VOSegmentText:@"技术"}]];
        self.segmentedControl.frame = CGRectMake(0, 64, kScreenWidth, 44);
        self.segmentedControl.contentStyle = VOContentStyleTextAlone;
        self.segmentedControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        
        self.segmentedControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.segmentedControl.selectedBackgroundColor = self.segmentedControl.backgroundColor;
        
        self.segmentedControl.textFont = [UIFont systemFontOfSize:17.0f];
        self.segmentedControl.allowNoSelection = NO;
        self.segmentedControl.indicatorThickness = 7;
        self.segmentedControl.selectedSegmentIndex = 0;
        
        [self.segmentedControl addTarget:self action:@selector(segmentCtrlValuechange) forControlEvents:UIControlEventValueChanged];

//        [self mainTableView];
    }
    return _segmentedControl;
}

-(PullingRefreshTableView *)mainTableView{
    if (_mainTableView == nil) {
        self.mainTableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 44+64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.mainTableView.pullingDelegate = self;
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.rowHeight = 120;
        self.mainTableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        
        self.leftSwipe =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipes:)];
        self.rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handSwipes:)];
        
        self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.mainTableView addGestureRecognizer:self.leftSwipe];
        [self.mainTableView addGestureRecognizer:self.rightSwipe];

//        [self.newsView addSubview:self.mainTableView];
    }
    return _mainTableView;
}


#pragma mark---------------Custom Method

-(void)handSwipes:(UISwipeGestureRecognizer *)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.segmentedControl.selectedSegmentIndex -=1;
        [self segmentCtrlValuechange];
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        self.segmentedControl.selectedSegmentIndex += 1;
        [self segmentCtrlValuechange];
    }
}

-(void)selectBtn{
     if (_segmentedControl.selectedSegmentIndex == NewListTypeHome){
        self.allNewsArray = self.homeNewsArray;
    }else if(_segmentedControl.selectedSegmentIndex==NewListTypeIndustry) {
        self.allNewsArray = self.OneNewsArray;
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeWatch){
        self.allNewsArray = self.TwoNewsArray;
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeDepth){
        self.allNewsArray = self.ThreeNewsArray;
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeOperating){
        self.allNewsArray = self.FourNewsArray;
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeProduct) {
        self.allNewsArray = self.FiveNewsArray;
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeTechnology){
        self.allNewsArray = self.SixNewsArray;
    }
    [self.mainTableView reloadData];
    [self.mainTableView tableViewDidFinishedLoading];
    self.mainTableView.reachedTheEnd = NO;
    
    

}
//首页
-(void)requestLoad{
    AFHTTPSessionManager *sessionManage =[AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kHomepage;
    if (!self.refreshing) {
      url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
    [ProgressHUD show:@"正在刷新数据..."];
    [sessionManage GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *newsArray = responseObject;
        if (self.refreshing) {
            if (self.OneNewsArray.count > 0) {
                [self.OneNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in newsArray) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.homeNewsArray addObject:model];
//            NSLog(@"%@",self.allNewsArray);
        }
        
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];
}
//业界
-(void)getIndustryRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kIndustry;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
    [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url  parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.OneNewsArray.count > 0) {
                [self.OneNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.OneNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];
    
}

-(void)getWatchRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kWatch;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
    [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.TwoNewsArray.count > 0) {
                [self.TwoNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.TwoNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];    }];

}

-(void)getDepthRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kDepth;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
     [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.ThreeNewsArray.count > 0) {
                [self.ThreeNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.ThreeNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];

}
-(void)getOperatingRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kOperating;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
     [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.FourNewsArray.count > 0) {
                [self.FourNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.FourNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];    }];

}

-(void)getProductRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kProduct;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
    [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.FiveNewsArray.count > 0) {
                [self.FiveNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.FiveNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];

}
-(void)getTechnologyRequest{
    AFHTTPSessionManager *sessionManager =[ AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = kTechnology;
    if (!_refreshing) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/time/%lu/type/%lu",_timeStamp,_type]];
    }else{
        if (self.allNewsArray.count > 0) {
            [self.allNewsArray removeAllObjects];
        }
    }
     [ProgressHUD show:@"正在刷新数据..."];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载完成..."];
        NSArray *array = responseObject;
        if (self.refreshing) {
            if (self.SixNewsArray.count > 0) {
                [self.SixNewsArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            newsModel *model = [[newsModel alloc]initWithDictionary:dic];
            [self.SixNewsArray addObject:model];
            //            NSLog(@"%@",self.allNewsArray);
        }
        [self selectBtn];
//        [self.mainTableView reloadData];
//        [self.mainTableView tableViewDidFinishedLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];

}
#pragma mark---------UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newsModel *model = self.allNewsArray[indexPath.row];
    ViewController *view = [[ViewController alloc] init];
    UINavigationController *viewVC = [[UINavigationController alloc]initWithRootViewController:view];
    view.ActivityId = model.newsId;
    view.TypeId = model.typeId;
    view.titleStr = model.title;
    view.photoStr = model.img;
    view.subTitle = model.summ;
    [self.navigationController presentViewController:viewVC animated:YES completion:nil];
}

#pragma mark-------------UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", self.allNewsArray.count);
    return self.allNewsArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    newsModel *model = self.allNewsArray[indexPath.row];
    cell.model = model;

    cell.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];

    return cell;
}


#pragma mark----------PullingRefreshTableViewDelegate

//下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    _type = 0;
    [self performSelector:@selector(segmentCtrlValuechange) withObject:nil afterDelay:1.0];
}
//上拉
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    if (_timeStamp > 3600*10) {
        _timeStamp-=3600*10;
    }
    _type +=1;
    self.refreshing = NO;
    [self performSelector:@selector(segmentCtrlValuechange) withObject:nil afterDelay:1.0];
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTools getSystemNowDate];
}
//手指拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.mainTableView tableViewDidScroll:scrollView];
}
//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.mainTableView tableViewDidEndDragging:scrollView];
    
}
- (void)segmentCtrlValuechange{
    if (_segmentedControl.selectedSegmentIndex==NewListTypeHome){
        [self requestLoad];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeIndustry){
        
        [self getIndustryRequest];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeWatch){
        [self getWatchRequest];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeDepth){
        [self getDepthRequest];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeOperating){
        [self getOperatingRequest];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeProduct) {
        [self getProductRequest];
    }else if (_segmentedControl.selectedSegmentIndex == NewListTypeTechnology){

        [self getTechnologyRequest];
    }

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
