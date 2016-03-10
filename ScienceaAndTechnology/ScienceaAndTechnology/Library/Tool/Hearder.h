//
//  Hearder.h
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#ifndef Hearder_h
#define Hearder_h

typedef NS_ENUM(NSInteger,NewListType) {
    NewListTypeHome,
    NewListTypeIndustry ,//业界
    NewListTypeWatch ,      //看点
    NewListTypeDepth,      //深度
    NewListTypeOperating,  //运营
    NewListTypeProduct,    //产品
    NewListTypeTechnology  //技术
};

typedef NS_ENUM(NSInteger,DiscoverListType) {
    DiscoverListTypeFinancial,
    DiscoverListTypeWrite 
//    DiscoverListTypeVideo 
};



#define  news @"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1457309996/type/1?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"

//首页接口
#define kNewsColumn @"http://news.coolban.com/Api/Index/category_list/app/2?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
#define kHomepage @"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//业界
#define kIndustry @"http://news.coolban.com/Api/Index/news_list/app/2/cat/5/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//看点
#define kWatch @"http://news.coolban.com/Api/Index/news_list/app/2/cat/8/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//深度
#define kDepth @"http://news.coolban.com/Api/Index/news_list/app/2/cat/4/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//运营
#define kOperating @"http://news.coolban.com/Api/Index/news_list/app/2/cat/6/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=6"
//产品
#define kProduct @"http://news.coolban.com/Api/Index/news_list/app/2/cat/3/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=6"
//技术
#define kTechnology @"http://news.coolban.com/Api/Index/news_list/app/2/cat/7/limit/20?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"

//#define kActivity @"http://news.coolban.com/Api/Index/get_news/app/2/autoload/1?"

#define kActivity @"http://news.coolban.com/Web/Index/land/app/2"

//金融
#define kFinancial @"http://content.cdn.bb.bbwc.cn/slateInterface/v7/app_1/android/tag/cat_12/articlelist?updatetime=1454062401"
//特写
#define kCloseup @"http://content.cdn.bb.bbwc.cn/slateInterface/v7/app_1/android/tag/cat_18/articlelist?updatetime=1454062401"

//视频
#define kVideo @"http://content.cdn.bb.bbwc.cn/slateInterface/v7/app_1/android/tag/cat_14/articlelist?updatetime=1454062401"

#define kAppKey @"4045536466"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"

#endif /* Hearder_h */
