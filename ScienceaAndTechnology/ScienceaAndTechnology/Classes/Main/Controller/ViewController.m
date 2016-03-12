//
//  ViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "WeiboSDK.h"
#import "shareView.h"
#import "Shoucang.h"

@interface ViewController ()
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;
@property(nonatomic,strong) NSString *urlString;
@property(nonatomic,strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.navigationController.navigationBar.barTintColor = mainColor;
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scalesPageToFit = YES;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0,kScreenWidth * 20/375,kScreenHeight * 20/667);
    [rightBtn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareActivityAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.frame = CGRectMake(kScreenWidth * 40/375, 0,kScreenWidth * 20/375,kScreenHeight * 20/667);
    [twoBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [twoBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightTwoBtn = [[UIBarButtonItem alloc] initWithCustomView:twoBtn];
    NSArray *rightBtns = @[rightTwoBtn,rightBarBtn];
    self.navigationItem.rightBarButtonItems = rightBtns;

    [self.view addSubview:self.webView];
    [self backBtn];
    [self loadString:self.ActivityId];
    [self titleString];
    [self titString:self.titleStr];
//    [self photoString:self.photoStr];


}

-(void)titleString{
    if ([self.TypeId isEqualToString:@"5"]) {
        self.navigationItem.title = @"业界";
    }else if ([self.TypeId isEqualToString:@"8"]){
        self.navigationItem.title = @"看点" ;
    }else if ([self.TypeId isEqualToString:@"4"]){
        self.navigationItem.title = @"深度";
    }else if ([self.TypeId isEqualToString:@"6"]){
        self.navigationItem.title = @"运营";
    }else if ([self.TypeId isEqualToString:@"3"]){
        self.navigationItem.title = @"产品";
    }else if ([self.TypeId isEqualToString:@"7"]){
        self.navigationItem.title = @"技术";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)loadString:(NSString *)str{
    NSString *url = str;
    if (![str hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:@"%@/id/%@",kActivity,url];
            }
    NSURL *urlStr = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [self.webView loadRequest:request];
//    self.urlString = str;
   
}

-(void)titString:(NSString *)title{
    self.urlString = title;
}

//-(void)photoString:(NSString *)photo{
//    self.photoStr = [photo substringToIndex:61];
//}

-(void)like{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏已成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    Shoucang *manager = [Shoucang sharedInstance];
    Model *model = [[Model alloc] init];
    model.title = self.titleStr;
    model.subTitle = self.subTitle;
    model.Titleimage = self.photoStr;
    NSLog(@"%@",model.title);
    [manager insertIntoNewModel:model];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)shareActivityAction:(UIButton *)btn{
    
    shareView *sharVc = [[shareView alloc]init];
    sharVc.sharUrlString = self.urlString;
    NSLog(@"%@",sharVc.sharUrlString);
    sharVc.photoStr = self.photoStr;
//    NSLog(@"%@",sharVc.photoStr);
    
    [self.view addSubview:sharVc];
        
    
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
