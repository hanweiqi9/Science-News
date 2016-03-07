//
//  AppDelegate.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MineViewController.h"
#import "WeiboSDK.h"
#import "DiscoverViewController.h"

@interface AppDelegate ()<WeiboSDKDelegate>


@end

@implementation AppDelegate
@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //注册微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"4045536466"];
    
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    mainVC.tabBarItem.image = [UIImage imageNamed:@"ft_home_normal_ic"];
    UIImage *mainSelectImage =[ UIImage imageNamed:@"ft_home_selected_ic"];
    mainVC.tabBarItem.selectedImage = [mainSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    mainVC.tabBarItem.title = @"科技";
    mainVC.navigationItem.title = @"科技";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    mainVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    discoverVC.tabBarItem.image = [UIImage imageNamed:@"ft_found_normal_ic"];
    UIImage *discoverSelectImage =[ UIImage imageNamed:@"ft_found_selected_ic"];
    discoverVC.tabBarItem.selectedImage = [discoverSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    discoverVC.tabBarItem.title = @"发现";
    discoverVC.navigationItem.title = @"金融界";
    UINavigationController *dicNav = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    discoverVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    UIStoryboard *mineStory = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *mine = mineStory.instantiateInitialViewController;
    mine.tabBarItem.image = [UIImage imageNamed:@"ft_person_normal_ic"];
    UIImage *mineSelectImage = [UIImage imageNamed:@"ft_person_selected_ic"];
    mine.tabBarItem.selectedImage = [mineSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mine.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    tabBarVC.viewControllers = @[nav,dicNav, mine];
    
    tabBarVC.tabBar.barTintColor = [UIColor blackColor];
    tabBarVC.delegate = self;
    

    self.window.rootViewController = tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:self];
}



-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
