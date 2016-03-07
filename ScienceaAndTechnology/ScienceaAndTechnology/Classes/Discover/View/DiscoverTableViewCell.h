//
//  DiscoverTableViewCell.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiscoverTableViewCell : UITableViewCell
@property(nonatomic,strong) DiscoverModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end
