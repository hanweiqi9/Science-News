//
//  NewsTableViewCell.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;


@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(newsModel *)model{
//    if ([model.img isEqualToString:@""]) {
//        self.titleLabel.frame = CGRectMake(8, 7, 308, 39);
//        self.titleLabel.text = model.newstitle;
//    }else{
    
    self.titleLabel.text = model.newstitle;
    self.nameLabel.text = model.name;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        
//    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
