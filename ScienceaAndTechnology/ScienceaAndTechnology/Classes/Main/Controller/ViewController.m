//
//  ViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>


@interface ViewController ()
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.navigationController.navigationBar.barTintColor = mainColor;
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareActivityAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    [self.view addSubview:self.webView];
    [self backBtn];
    [self loadString:self.ActivityId];
    [self titleString];


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
}


-(void)shareActivityAction:(UIButton *)btn{
    
    UIWindow *window =[[UIApplication sharedApplication].delegate window];
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.5;
    [window addSubview:self.grayView];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 400)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.shareView];
    
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(30, 40, 70, 70);
    [weiboBtn setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(weiboActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 100, 44)];
    weiboLabel.text = @"新浪微博";
    weiboLabel.font = [UIFont systemFontOfSize:13.0f];
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:weiboLabel];
    [self.shareView addSubview:weiboBtn];
    
    //微信朋友
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(155, 40, 70, 70);
    [friendBtn setImage:[UIImage imageNamed:@"icon_pay_weixin"] forState:UIControlStateNormal];
    [friendBtn addTarget:self action:@selector(friendActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *friendLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 85, 100, 44)];
    friendLabel.text = @"微信好友";
    friendLabel.font = [UIFont systemFontOfSize:13.0f];
    friendLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:friendLabel];
    [self.shareView addSubview:friendBtn];
    //朋友圈
    UIButton *CircleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CircleBtn.frame = CGRectMake(270, 40, 70, 70);
    [CircleBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [CircleBtn addTarget:self action:@selector(CircleActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 85, 100, 44)];
    circleLabel.text = @"微信朋友圈";
    circleLabel.font = [UIFont systemFontOfSize:13.0f];
    circleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:circleLabel];
    [self.shareView addSubview:CircleBtn];
    
//    //短信
//    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    messageBtn.frame = CGRectMake(30, 120, 70, 70);
//    [messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//    [messageBtn addTarget:self action:@selector(messageActivity) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 165, 100, 44)];
//    messageLabel.text = @"短信";
//    messageLabel.font = [UIFont systemFontOfSize:13.0];
//    messageLabel.textAlignment = NSTextAlignmentCenter;
//    [self.shareView addSubview:messageBtn];
//    [self.shareView addSubview:messageLabel];
    
    
    //取消
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(0, 200, kScreenWidth, 40);
    [removeBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [removeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(last ) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = [UIColor whiteColor];
    [self.shareView addSubview:removeBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100 , 30)];
    label.text = @"分享给朋友";
    label.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:label];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.shareView.frame = CGRectMake(0, kScreenHeight-250, kScreenWidth, 350);
    }];

    
    
}

-(void)last{
    [self.shareView removeFromSuperview];
    [self.grayView removeFromSuperview];
}

-(void)weiboActivity{
    
}

-(void)friendActivity{
    
}

-(void)CircleActivity{
    
}

-(void)messageActivity{
    
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
