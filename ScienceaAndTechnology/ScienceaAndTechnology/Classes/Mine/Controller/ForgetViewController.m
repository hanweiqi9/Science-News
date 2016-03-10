//
//  ForgetViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "ForgetViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"

@interface ForgetViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *passText;
@property(nonatomic,strong) UITextField *againText;



@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"14.jpg"]];
    
    self.navigationController.navigationBar.barTintColor = mainColor;
    self.navigationItem.title = @"重置密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self backBtn];
    
    self.passText = [[UITextField alloc]initWithFrame:CGRectMake(60, 150, kScreenWidth-120, 44)];
    self.passText.placeholder = @"请输入原密码";
    self.passText.borderStyle = UITextBorderStyleRoundedRect;
    self.passText.delegate=self;
    [self.view addSubview:self.passText];
    
    self.againText = [[UITextField alloc] initWithFrame:CGRectMake(60, 210, kScreenWidth-120, 44)];
    self.againText.placeholder = @"请输入新密码";
    self.againText.borderStyle = UITextBorderStyleRoundedRect;
    self.againText.secureTextEntry = YES;
    self.againText.delegate=self;
    [self.view addSubview:self.againText];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(80, 280, kScreenWidth-160, 44);
    [button1 setBackgroundColor:mainColor];
    [button1 setTitle:@"确 定" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button1 addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];

    

}

-(void)forget{
    BmobUser *user = [BmobUser getCurrentUser];
    [user updateCurrentUserPasswordWithOldPassword:self.passText.text newPassword:self.againText.text block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"重置成功"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];

        } else {
            [ProgressHUD showError:@"重置失败"]; 
        }
    }];
    
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
