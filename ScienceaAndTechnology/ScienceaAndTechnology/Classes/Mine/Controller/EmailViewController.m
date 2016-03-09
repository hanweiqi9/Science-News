//
//  EmailViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "EmailViewController.h"
#import <BmobSDK/Bmob.h>

@interface EmailViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *emialText;

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"11.jpg"]];
    
    self.navigationController.navigationBar.barTintColor = mainColor;
    self.navigationItem.title = @"找回密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self backBtn];
    
    self.emialText = [[UITextField alloc]initWithFrame:CGRectMake(60, 150, kScreenWidth-120, 50)];
    self.emialText.placeholder = @"请输入邮箱";
    self.emialText.borderStyle = UITextBorderStyleRoundedRect;
    self.emialText.delegate=self;
    [self.view addSubview:self.emialText];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(80, 280, kScreenWidth-160, 44);
    [button1 setBackgroundColor:mainColor];
    [button1 setTitle:@"确 定" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
}

-(void)back{
    [BmobUser requestPasswordResetInBackgroundWithEmail:self.emialText.text];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"邮箱发送成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
