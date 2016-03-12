//
//  NewsTableViewCell.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HWTools.h"
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
    
//    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
//    
//    if (self.photoImage != nil) {
//        self.titleLabel.text = model.newstitle;
//        self.nameLabel.text = model.name;
//        self.contentLabel.text = model.summ;
//
//    }if (self.photoImage == nil) {
//        self.timeLabel.frame = CGRectMake(14, 12, 339,40 );
//        self.timeLabel.text = model.newstitle;
//        self.nameLabel.text = model.name;
//        self.contentLabel.frame = CGRectMake(14, 55, 339, 40);
//        self.contentLabel.text = model.summ;
//    }
    if (model.img.length>0) {
        self.titleLabel.text = model.newstitle;
        self.nameLabel.text = model.name;
        self.contentLabel.text = model.summ;
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    }else if (model.img.length == 0){
        self.titleLabel.frame = CGRectMake(kScreenWidth * 14/375,kScreenHeight * 12/667,kScreenWidth * 339/375,kScreenHeight * 40/667 );
        self.titleLabel.text = model.newstitle;
        self.nameLabel.text = model.name;
        self.contentLabel.frame = CGRectMake(kScreenWidth * 14/375,kScreenHeight * 55/667,kScreenWidth * 339/375,kScreenHeight * 40/667);
        self.contentLabel.text = model.summ;
    }
   
   
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
