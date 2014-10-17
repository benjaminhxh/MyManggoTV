//
//  AppDelegate.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "AppDelegate.h"

#import "PublicHeader.h"

@interface AppDelegate () <MyTabBarDelegate>
{
    UITabBarController *tabBarCtrl;
}

@end

@implementation AppDelegate
- (void)tabBar:(MyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    tabBarCtrl.selectedIndex = index;
}

- (void)createTabBar
{
    NSArray *images = @[@"TabBarRecommendIcon.png",
                        @"TabBarHomeLiveIcon.png",
                        @"TabBarHomeChannelsIcon.png",
                        @"TabBarHomeSearchIcon.png",
                        @"TabBarHomeMoreIcon.png"];
    
    NSArray *seletedimages = @[@"TabBarRecommendSelectedIcon.png",
                               @"TabBarHomeLiveSelectedIcon.png",
                               @"TabBarHomeChannelsSelectedIcon.png",
                               @"TabBarHomeSearchSelectedIcon.png",
                               @"TabBarHomeMoreSelectedIcon.png"];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:images[i]];
        UIImage *seletedimage = [UIImage imageNamed:seletedimages[i]];
        MyTabBarItem *item = [[MyTabBarItem alloc] initWithImage:image selectedimage:seletedimage title:nil];
        item.selectedbgImage = [UIImage imageNamed:@"TabBarHomeBackgroundSelected.png"];
        [itemsArray addObject:item];
    }
    
    MyTabBar *tabBar = [[MyTabBar alloc] initWithFrame:tabBarCtrl.tabBar.bounds];
    
    tabBar.items = itemsArray;
    tabBar.backgroundImage = [UIImage imageNamed:@"TabBarBackground.png"];
    tabBar.delegate = self;
    tabBar.selectedIndex = 0;
    [tabBarCtrl.tabBar addSubview:tabBar];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomeViewController *homeCtrl = [[HomeViewController alloc] init];
    UINavigationController *navCtrl0 = [[UINavigationController alloc] initWithRootViewController:homeCtrl];
    [navCtrl0.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    LiveViewController *liveCtrl = [[LiveViewController alloc] init];
    UINavigationController *navCtrl1 = [[UINavigationController alloc] initWithRootViewController:liveCtrl];
    [navCtrl1.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground.png"] forBarMetrics:UIBarMetricsDefault];
    ChannelViewController *channelCtrl = [[ChannelViewController alloc] init];
    UINavigationController *navCtrl2 = [[UINavigationController alloc] initWithRootViewController:channelCtrl];
    [navCtrl2.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground.png"] forBarMetrics:UIBarMetricsDefault];
    SearchViewController *searchCtr = [[SearchViewController alloc] init];
    UINavigationController *navCtrl3 = [[UINavigationController alloc] initWithRootViewController:searchCtr];
    [navCtrl3.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground.png"] forBarMetrics:UIBarMetricsDefault];
    MyViewController *myCtrl = [[MyViewController alloc] init];
    UINavigationController *navCtrl4 = [[UINavigationController alloc] initWithRootViewController:myCtrl];
    [navCtrl4.navigationBar setBackgroundImage:[UIImage imageNamed:@"RecommandationViewTitleBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    tabBarCtrl = [[UITabBarController alloc] init];
    tabBarCtrl.viewControllers = @[navCtrl0, navCtrl1, navCtrl2, navCtrl3, navCtrl4];
    self.window.rootViewController = tabBarCtrl;
    
    [self createTabBar];
    
    return YES;
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
