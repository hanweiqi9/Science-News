//
//  newsModel.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsModel : NSObject

@property(nonatomic,copy)NSString *newsId;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *addtime;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *newstitle;
@property(nonatomic,copy)NSString *typeId;
@property (nonatomic, copy) NSString *summ;



-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
