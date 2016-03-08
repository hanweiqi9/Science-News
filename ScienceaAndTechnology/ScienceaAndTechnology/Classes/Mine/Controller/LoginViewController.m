//
//  LoginViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>

@interface LoginViewController ()<UITextFieldDelegate,MFMailComposeViewControllerDelegate>
@property(nonatomic,strong) UITextField *userName;
@property(nonatomic,strong) UITextField *userPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    self.navigationItem.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self backBtn];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 80, 30)];
    text.text = @"用户名";
    text.textColor = [UIColor blackColor];
    [self.view addSubview:text];
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(135, 150, 200, 30)];
    self.userName.placeholder = @"QQ号/手机号/邮箱";
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.delegate=self;
    [self.view addSubview:self.userName];
    
    UILabel *text2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 190, 80, 30)];
    text2.text = @"密 码";
    text2.textColor = [UIColor blackColor];
    [self.view addSubview:text2];
    self.userPassword = [[UITextField alloc] initWithFrame:CGRectMake(135, 190, 200, 30)];
    self.userPassword.placeholder = @"请输入密码";
    self.userPassword.borderStyle = UITextBorderStyleRoundedRect;
    self.userPassword.secureTextEntry = YES;
    self.userPassword.delegate=self;
    [self.view addSubview:self.userPassword];
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(55, 280, 80, 30);
//    [button setBackgroundColor:[UIColor grayColor]];
//    [button setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:
//     UIControlStateNormal];
//    
//    [self.view addSubview:button];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(55, 280, kScreenWidth-110, 44);
    [button1 setBackgroundColor:mainColor];
    [button1 setTitle:@"登  陆" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(55, 334, kScreenWidth-110, 44);
    [button2 setBackgroundColor:mainColor];
    [button2 setTitle:@"注  册" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

-(void)login{
    [BmobUser loginInbackgroundWithAccount:self.userName.text andPassword:self.userPassword.text block:^(BmobUser *user, NSError *error) {
        [ProgressHUD show:@"正在为您登录，请稍等 ..."];
        if (user) {
            [ProgressHUD showSuccess:@"登录成功"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已成功登录" message:@"是否留下反馈意见" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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

            }];
            [alert addAction:alert1];
            [alert addAction:alert2];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [ProgressHUD showError:@"登录失败"];
        }
    }];
    
    
    
}


- (void)zhuce{
    RegisterViewController *regis =[[RegisterViewController alloc] init];
    UINavigationController *registVC =[[UINavigationController alloc] initWithRootViewController:regis];
    [self.navigationController presentViewController:registVC animated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
