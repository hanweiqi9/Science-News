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
    
    self.titleLabel.text = model.newstitle;
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.summ;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
   

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
