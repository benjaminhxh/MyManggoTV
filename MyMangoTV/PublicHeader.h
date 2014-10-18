//
//  PublicHeader.h
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//
#import "MyTabBarItem.h"
#import "MyTabBar.h"

#import "HomeViewController.h"
#import "LiveViewController.h"
#import "ChannelViewController.h"
#import "SearchViewController.h"
#import "MyViewController.h"
#import "DetailViewController.h"
#import "AFNetworking.h"

//百度ak/sk
#define msAK                    @"ZIAgdlC7Vw7syTjeKG9zS4QP"
#define msSK                    @"pavlqfU4mzYQ1dH0NG3b7LyXNBy5SYk6"

#define backGroundImage         @"beijing@2x"
#define navigationBarImageiOS7  @"bantou_dida@2x"
#define navigationBarImage      @"bantou_di@2x"
#define backBtnImage            @"cehuajiantou18x34@2x"
#define kUserInfoNotification   @"userInfoNotification"
#define kAPPWillResignActivenotif @"applicationWillResignActive"


#define iOS8 [[UIDevice currentDevice].systemVersion integerValue]>=8
#define iOS7 [[UIDevice currentDevice].systemVersion integerValue]>=7
#define iphone5     [UIScreen mainScreen].bounds.size.height > 480
#define KdurationFail 8.0
#define KdurationSuccess 1.0

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
