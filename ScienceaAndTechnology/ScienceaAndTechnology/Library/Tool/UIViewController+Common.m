//
//  UIViewController+Common.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "UIViewController+Common.h"
#import "MainViewController.h"
#import "DiscoverViewController.h"

@implementation UIViewController (Common)

-(void)backBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [backBtn addTarget:self action:@selector(backBtnActivity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}



-(void)backBtnActivity{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
