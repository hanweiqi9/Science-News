//
//  LineViewController.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineViewController : UIViewController
@property(nonatomic,strong) UIWebView *WebView;
@property(nonatomic,copy) NSString *urlStr;
@property(nonatomic,copy) NSString *titleStr;
@property(nonatomic,copy) NSString *topimage;
@property(nonatomic,copy) NSString *subtitle;

@end
