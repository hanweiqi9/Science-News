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
#import "ShouCangViewController.h"



@interface MineViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic,assign) float level;

@property(nonatomic,strong) UIView *score1;
@property(nonatomic,strong) UIView *grayView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"14.jpg"]];
    self.photoLabel.backgroundColor = [UIColor clearColor];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger cacheSize = [cache getSize];
    self.photoLabel.text = [NSString stringWithFormat:@" 清除图片缓存 (%.02fM)",(float)cacheSize/1024/1024];
    self.scoreLabel.text = [NSString stringWithFormat:@" 给我评分"];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(kScreenWidth * 1/3, kScreenHeight * 4/15, kScreenWidth/3, kScreenWidth/3);
    loginBtn.layer.cornerRadius=kScreenWidth/6;
    loginBtn.clipsToBounds=YES;
    [loginBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnActivity) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:loginBtn];
    
}

-(void)loginBtnActivity{
    LoginViewController *loginView = [[LoginViewController alloc] init];
    UINavigationController *loginVC = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
    
}

- (IBAction)removeAction:(id)sender {
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache cleanDisk];
    self.photoLabel.text = [NSString stringWithFormat:@" 清除图片缓存 "];
}

- (IBAction)userAction:(id)sender {    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"用户反馈"];
            NSArray *toPerson = [NSArray arrayWithObjects:@"1072502398@qq.com", nil];
            [picker setToRecipients:toPerson];
            NSString *text = @"请留下你的宝贵意见";
            [picker setMessageBody:text isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            [ProgressHUD showError:@"您的设备尚未配置邮件账号"];
        }
    }else{
        [ProgressHUD showError:@"您的设备不支持邮件功能"];
    }

}
- (IBAction)gradeAction:(id)sender {
//    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app"];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.5;
    [self.view addSubview:self.grayView];
    
    self.score1 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kScreenHeight * 300/667, kScreenWidth,kScreenHeight * 400/667)];
    self.score1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.score1];
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(kScreenWidth * 4/75,kScreenHeight * 200/667, kScreenWidth- kScreenWidth * 8/75,kScreenHeight * 40/667);
    [removeBtn setTitle:@"评分" forState:UIControlStateNormal];
    [removeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(last ) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = mainColor;
    [self.score1 addSubview:removeBtn];
    
    LPLevelView *lView = [LPLevelView new];
    lView.frame = CGRectMake(kScreenWidth * 23/75, kScreenHeight * 16/75, kScreenWidth * 6/75, kScreenHeight * 44/667);
    lView.iconColor = [UIColor orangeColor];
    lView.iconSize = CGSizeMake(kScreenWidth * 4/75, kScreenHeight * 4/75);
    lView.canScore = YES;
    lView.animated = YES;
    lView.level = 3.5;
    [lView setScoreBlock:^(float level) {
        self.level = level;
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
            self.scoreLabel.text = [NSString stringWithFormat:@" 给我评分 (%.f 分)",self.level];

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
- (IBAction)shoucangBtn:(id)sender {
    ShouCangViewController *shoucang = [[ShouCangViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shoucang];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
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
