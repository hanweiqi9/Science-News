//
//  DiscoverModel.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverModel : UIView
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *photo;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic,copy) NSString *topPicture;
@property(nonatomic,copy) NSString *urlStr;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
