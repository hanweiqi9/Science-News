//
//  newsModel.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "newsModel.h"

@implementation newsModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.newsId = dic[@"id"];
        self.title = dic[@"title"];
        self.name = dic[@"sitename"];
        self.newstitle = dic[@"title"];
        self.img = dic[@"img"];
        self.typeId = dic[@"type_id"];
        self.summ = dic[@"summary"];
        self.addtime = dic[@"addtime"];
    }
    return self;
}

@end
