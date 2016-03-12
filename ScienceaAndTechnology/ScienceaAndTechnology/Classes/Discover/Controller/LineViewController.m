//
//  LineViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "LineViewController.h"
#import "shareView.h"
#import "Shoucang.h"


@interface LineViewController ()
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;
//@property(nonatomic,strong) NSString *urlStr;
@end

@implementation LineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = mainColor;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, kScreenWidth * 44/375,kScreenHeight * 44/667);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0,kScreenWidth * (-10/375), 0,kScreenHeight * 10/667)];
    [backBtn addTarget:self action:@selector(backBtnActivity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0,kScreenWidth * 20/375,kScreenHeight * 20/667);
    [rightBtn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareActivityAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.frame = CGRectMake(kScreenWidth * 40/kScreenWidth, 0,kScreenWidth * 20/kScreenWidth,kScreenHeight * 20/667);
    [twoBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [twoBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightTwoBtn = [[UIBarButtonItem alloc] initWithCustomView:twoBtn];
    NSArray *rightBtns = @[rightTwoBtn,rightBarBtn];
    self.navigationItem.rightBarButtonItems = rightBtns;
    
    self.WebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.WebView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:self.WebView];
    [self loadString:self.urlStr];
}

-(void)loadString:(NSString *)str{
    NSString *url = str;
    NSURL *urlStr = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [self.WebView loadRequest:request];
    self.urlStr = str;
    
}

-(void)backBtnActivity{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)shareActivityAction:(UIButton *)btn{
    
    shareView *shareVC = [[shareView alloc] init];
    shareVC.sharUrlString = self.urlStr;
    [self.view addSubview:shareVC];
    
}


-(void)like{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏已成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Shoucang *manager = [Shoucang sharedInstance];
        Model *model = [[Model alloc] init];
        model.title = self.title;
        model.subTitle = self.subtitle;
        model.Titleimage = self.topimage;
        NSLog(@"%@",model.title);
        [manager insertIntoNewModel:model];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    

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
