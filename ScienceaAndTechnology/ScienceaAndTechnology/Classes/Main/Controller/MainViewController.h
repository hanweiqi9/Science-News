//
//  MainViewController.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsModel.h"

@interface MainViewController : UIViewController
@property(nonatomic,copy) newsModel *model;
@property(nonatomic,assign) NewListType *newListType;


@end
