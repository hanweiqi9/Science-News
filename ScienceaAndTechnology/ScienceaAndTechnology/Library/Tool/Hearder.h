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


//首页接口
#define kNewsColumn @"http://news.coolban.com/Api/Index/category_list/app/2?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
#define kHomepage @"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1457061667/type/1?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//业界
#define kIndustry @"http://news.coolban.com/Api/Index/news_list/app/2/cat/5/limit/20/time/1456971649/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//看点
#define kWatch @"http://news.coolban.com/Api/Index/news_list/app/2/cat/8/limit/20/time/1456970200/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//深度
#define kDepth @"http://news.coolban.com/Api/Index/news_list/app/2/cat/4/limit/20/time/1456972528/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//运营
#define kOperating @"http://news.coolban.com/Api/Index/news_list/app/2/cat/6/limit/20/time/1456966812/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=6"
//产品
#define kProduct @"http://news.coolban.com/Api/Index/news_list/app/2/cat/3/limit/20/time/1456955997/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=6"
//技术
#define kTechnology @"http://news.coolban.com/Api/Index/news_list/app/2/cat/7/limit/20/time/1456966947/type/0?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"

//#define kActivity @"http://news.coolban.com/Api/Index/get_news/app/2/autoload/1?"

#define kActivity @"http://news.coolban.com/Web/Index/land/app/2"

//"http://news.coolban.com/Api/Index/get_news/app/2/id/388783/autoload/1?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"
//"http://news.coolban.com/Api/Index/get_news/app/2/autoload/1?uuid=Honor%2FCHM-TL00%2FhwCHM-H%3A4.4.2%2FHonorCHM-TL00%2FC01B231%3Auser%2Fota-rel-keys%2Crelease-keys&model=Android&channel=default&net=5&ver=600"



#endif /* Hearder_h */
