//
//  shareView.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "shareView.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "WXApi.h"

@interface shareView ()<WeiboSDKDelegate,WXApiDelegate>
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;

@end

@implementation shareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

-(void)configView{
    UIWindow *window =[[UIApplication sharedApplication].delegate window];
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.5;
    [window addSubview:self.grayView];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 400)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.shareView];
    
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(30, 40, 70, 70);
    [weiboBtn setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(weiboActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 100, 44)];
    weiboLabel.text = @"新浪微博";
    weiboLabel.font = [UIFont systemFontOfSize:13.0f];
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:weiboLabel];
    [self.shareView addSubview:weiboBtn];
    
    //微信朋友
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(155, 40, 70, 70);
    [friendBtn setImage:[UIImage imageNamed:@"icon_pay_weixin"] forState:UIControlStateNormal];
    [friendBtn addTarget:self action:@selector(friendActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *friendLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 85, 100, 44)];
    friendLabel.text = @"微信好友";
    friendLabel.font = [UIFont systemFontOfSize:13.0f];
    friendLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:friendLabel];
    [self.shareView addSubview:friendBtn];
    //朋友圈
    UIButton *CircleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CircleBtn.frame = CGRectMake(270, 40, 70, 70);
    [CircleBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [CircleBtn addTarget:self action:@selector(CircleActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 85, 100, 44)];
    circleLabel.text = @"微信朋友圈";
    circleLabel.font = [UIFont systemFontOfSize:13.0f];
    circleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:circleLabel];
    [self.shareView addSubview:CircleBtn];
    
    //    //短信
    //    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    messageBtn.frame = CGRectMake(30, 120, 70, 70);
    //    [messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    //    [messageBtn addTarget:self action:@selector(messageActivity) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 165, 100, 44)];
    //    messageLabel.text = @"短信";
    //    messageLabel.font = [UIFont systemFontOfSize:13.0];
    //    messageLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.shareView addSubview:messageBtn];
    //    [self.shareView addSubview:messageLabel];
    
    
    //取消
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(0, 200, kScreenWidth, 40);
    [removeBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [removeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(last ) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = [UIColor whiteColor];
    [self.shareView addSubview:removeBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100 , 30)];
    label.text = @"分享给朋友";
    label.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
        self.shareView.frame = CGRectMake(0, kScreenHeight-250, kScreenWidth, 350);
    }];
    
}

-(void)last{
    [self.shareView removeFromSuperview];
    [self.grayView removeFromSuperview];
}


-(void)weiboActivity{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"MeViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    [self last];

}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = self.sharUrlString;
    WBImageObject *image1 = [WBImageObject object];
    image1.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"1" ofType:@".jpg"]];
    message.imageObject = image1;
    return message;
}


-(void)friendActivity{
    SendMessageToWXReq *req =[[SendMessageToWXReq alloc]init];
    req.text = self.sharUrlString;
    req.bText = YES;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}

-(void)CircleActivity{
    WXMediaMessage *message =[WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"tupian@2x.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@".jpg"];
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];

    
}





#pragma mark--------------WeiboSDKDelegate
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
