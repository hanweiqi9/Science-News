//
//  RegisterViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *userText;
@property(nonatomic,strong) UITextField *passwordText;
@property(nonatomic,strong) UITextField *passText;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    self.navigationItem.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self backBtn];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 80, 30)];
    text.text = @"用户名 ";
    text.textColor = [UIColor blackColor];
    [self.view addSubview:text];
    self.userText = [[UITextField alloc]initWithFrame:CGRectMake(135, 150, 200, 30)];
    self.userText.placeholder = @"QQ号/手机号/邮箱";
    self.userText.borderStyle = UITextBorderStyleRoundedRect;
    self.userText.delegate=self;
    [self.view addSubview:self.userText];
    
    UILabel *text2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 190, 80, 30)];
    text2.text = @"密  码";
    text2.textColor = [UIColor blackColor];
    [self.view addSubview:text2];
    self.passwordText = [[UITextField alloc] initWithFrame:CGRectMake(135, 190, 200, 30)];
    self.passwordText.placeholder = @"请输入密码";
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.secureTextEntry = YES;
    self.passwordText.delegate=self;
    [self.view addSubview:self.passwordText];
    UILabel *passLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 230, 80, 30)];
    passLabel.text = @"确认密码";
    passLabel.textColor = [UIColor blackColor];
    [self.view addSubview:passLabel];
    self.passText = [[UITextField alloc] initWithFrame:CGRectMake(135, 230, 200, 30)];
    self.passText.placeholder = @"请再次输入密码";
    self.passText.borderStyle = UITextBorderStyleRoundedRect;
    self.passText.secureTextEntry = YES;
    self.passText.delegate=self;
    [self.view addSubview:self.passText];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(55, 300, kScreenWidth-110, 44);
    [button1 setBackgroundColor:mainColor];
    [button1 setTitle:@"注   册" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button1];

}

-(void)zhuce{
    if (![self checkout]) {
        return;
    }
    [ProgressHUD show:@"正在为您注册中..."];
    BmobUser *user = [[BmobUser alloc] init];
    [user setUsername:self.userText.text];
    [user setPassword:self.passwordText.text];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜你" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [ProgressHUD showError:@"注册失败，请检查"];
        }
    }];
    
}

-(BOOL)checkout{
    //用户名不能为空，且不能为空格，注册前需要判断
    if (self.userText.text.length <= 0 || [self.userText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alertTwo = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名输入错误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        UIAlertAction *cancelActionTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertTwo addAction:actionTwo];
        [alertTwo addAction:cancelActionTwo];
        [self presentViewController:alertTwo animated:YES completion:nil];
        
        return NO;
    }
    //判断密码是否一致
    if (![self.passText.text isEqualToString:self.passwordText.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //输入密码不能为空
    if (self.passwordText.text.length <= 0 || [self.passwordText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        return NO;
    }
    return YES;
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
