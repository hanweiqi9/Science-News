//
//  ViewController.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,copy) NSString *ActivityId;
@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,copy) NSString *TypeId;



@end
