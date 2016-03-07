//
//  DiscoverModel.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "DiscoverModel.h"


@implementation DiscoverModel


-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.subtitle = dic[@"desc"];
        self.topPicture = dic[@"url"];
        self.photo = dic[@"url"];
        self.urlStr = dic[@"url"];
//
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
