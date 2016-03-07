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

@interface MineViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

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
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"用户反馈"];
            NSArray *toPerson = [NSArray arrayWithObjects:@"1072502398@qq.com   ", nil];
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
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
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
