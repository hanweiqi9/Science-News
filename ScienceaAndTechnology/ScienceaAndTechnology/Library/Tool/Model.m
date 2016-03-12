//
//  Model.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)initWithDictionary:(NSMutableDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.Titleimage = dic[@"imag"];
        self.subTitle = dic[@"subTitle"];
    }
    return self;
}

@end
