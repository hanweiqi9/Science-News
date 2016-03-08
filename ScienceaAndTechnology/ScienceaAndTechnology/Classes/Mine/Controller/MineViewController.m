//
//  MineViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "MineViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "LoginViewController.h"
#import "ScoreView.h"
#import "LPLevelView.h"


@interface MineViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
@property(nonatomic,strong) UIView *score1;
@property(nonatomic,strong) UIView *grayView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger cacheSize = [cache getSize];
    self.photoLabel.text = [NSString stringWithFormat:@" 清除图片缓存 (%.02fM)",(float)cacheSize/1024/1024];

    
}
- (IBAction)removeAction:(id)sender {
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache cleanDisk];
    self.photoLabel.text = [NSString stringWithFormat:@" 清除图片缓存 "];
}

- (IBAction)userAction:(id)sender {    
    UIAlertController *alter =  [UIAlertController alertControllerWithTitle:@"提示" message:@"是否需要登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *login =[[LoginViewController alloc] init];
        UINavigationController *loginVC = [[UINavigationController alloc] initWithRootViewController:login];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];

    }];
    [alter addAction:alert1];
    [alter addAction:alert2];
    [self presentViewController:alter animated:YES completion:nil];
    
    
    
    
}
- (IBAction)gradeAction:(id)sender {
//    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app"];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.5;
    [self.view addSubview:self.grayView];
    
    self.score1 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 400)];
    self.score1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.score1];
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(20, 200, kScreenWidth-40, 40);
    [removeBtn setTitle:@"评分" forState:UIControlStateNormal];
    [removeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(last ) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = mainColor;
    [self.score1 addSubview:removeBtn];
    
    LPLevelView *lView = [LPLevelView new];
    lView.frame = CGRectMake(115, 80, 150, 44);
    lView.iconColor = [UIColor orangeColor];
    lView.iconSize = CGSizeMake(20, 20);
    lView.canScore = YES;
    lView.animated = YES;
    lView.level = 3.5;
    [lView setScoreBlock:^(float level) {
        NSLog(@"打分：%f", level);
    }];
    [self.score1 addSubview:lView];
    
}


-(void)last{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要评分吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"评分成功" message:@"感谢您的支持" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.score1 removeFromSuperview];
            [self.grayView removeFromSuperview];
        }];
        [alert1 addAction:action1];
        [self presentViewController:alert1 animated:YES completion:nil];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.score1 removeFromSuperview];
        [self.grayView removeFromSuperview];
    }];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


- (IBAction)versionsAction:(id)sender {
    [ProgressHUD show:@"正在为您检测最新版本，请稍等..."];
    [self performSelector:@selector(check) withObject:nil afterDelay:2.0];
}

-(void)check{
    [ProgressHUD showSuccess:@"当前已是最新版本..."];
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
