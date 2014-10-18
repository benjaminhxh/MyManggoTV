//
//  PlayerViewController.m
//  MyMangoTV
//
//  Created by xiaohuihu on 14-10-17.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width

#define msAK                    @"ZIAgdlC7Vw7syTjeKG9zS4QP"
#define msSK                    @"pavlqfU4mzYQ1dH0NG3b7LyXNBy5SYk6"

#import "PlayerViewController.h"
#import "CyberPlayerController.h"

@interface PlayerViewController ()
{
    CyberPlayerController *cbPlayerController;
    NSTimer *timer;
    UILabel *titleL;
    BOOL topViewHidden;
    UIImageView *bottomView,*topView;
}
@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    //设置旋转动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    //设置视图旋转
    self.view.bounds = CGRectMake(0, 0, kWidth,kHeight);
    NSLog(@"kwidth:%f===========,kheight:%f",kWidth,kHeight);
    self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    [UIView commitAnimations];
    self.view.backgroundColor = [UIColor blackColor];
    
    //添加百度开发者中心应用对应的APIKey和SecretKey。
    //添加开发者信息
    [[CyberPlayerController class ]setBAEAPIKey:msAK SecretKey:msSK ];
    //当前只支持CyberPlayerController的单实例
    cbPlayerController = [[CyberPlayerController alloc] init];
    //清除残留影像
    cbPlayerController.shouldAutoClearRender = YES;
    //    NSString *SDKVerion = [cbPlayerController getSDKVersion];
    //    ////NSLog(@"SDKVersion:%@",SDKVerion);
    //设置视频显示的位置
    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kHeight, kWidth-44)];
    [cbPlayerController.view setFrame: videoView.frame];
//    cbPlayerController.scalingMode = CBPMovieScalingModeFill;
    //将视频显示view添加到当前view中
    [self.view addSubview:cbPlayerController.view];
    
    //注册监听，当播放器完成视频的初始化后会发送CyberPlayerLoadDidPreparedNotification通知，
    //此时naturalSize/videoHeight/videoWidth/duration等属性有效。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onpreparedListener:)
                                                 name: CyberPlayerLoadDidPreparedNotification
                                               object:nil];
    //注册监听，当播放器完成视频播放位置调整后会发送CyberPlayerSeekingDidFinishNotification通知，
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(seekComplete:)
                                                 name:CyberPlayerSeekingDidFinishNotification
                                               object:nil];
    //注册监听，当播放器播放完视频后发送CyberPlayerPlaybackDidFinishNotification通知，
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerBackDidFinish:)
                                                 name:CyberPlayerPlaybackDidFinishNotification
                                               object:nil];
    //注册监听，当播放器播放失败后发送CyberPlayerPlaybackErrorNotification通知，
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerBackError:)
                                                 name:CyberPlayerPlaybackErrorNotification
                                               object:nil];
    
    
    //注册监听，当播放器开始缓冲时发送通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(startCaching:)
    //                                                 name:CyberPlayerStartCachingNotification
    //                                               object:nil];
    //播放状态发生改变
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stateDidChange:)
                                                 name:CyberPlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
    //注册监听，当播放器缓冲视频过程中不断发送该通知。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GotCachePercent:)
                                                 name:CyberPlayerGotCachePercentNotification
                                               object:nil];


    //顶部条
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kHeight, 44)];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 12, 36, 20);
    //    backBtn.frame = CGRectMake(10, [UIApplication sharedApplication].statusBarFrame.size.height+5, 12, 22);
    [backBtn setImage:[UIImage imageNamed:@"fanhui_jiantou@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //标题
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(51, 12, kWidth-51-20, 20)];
    titleL.textColor = [UIColor whiteColor];
    titleL.backgroundColor = [UIColor clearColor];
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.text = self.playerTitle;
    [topView addSubview:titleL];

    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenOrNo:)];
    [cbPlayerController.view addGestureRecognizer:tapGest];

    [self startPlayback];
}

- (void)onDragSlideValueChanged:(id)sender {
    ////NSLog(@"slide changing, %f", slider.value);
//    [self refreshProgress:slider.value totalDuration:cbPlayerController.duration];
    //    ////NSLog(@"slider changing :%f",slider.progress);11/13
    //    [self refreshProgress:slider.progress totalDuration:cbPlayerController.duration];
}

- (void)onDragSlideDone:(id)sender {
//    float currentTIme = slider.value;
    ////NSLog(@"seek to %f", currentTIme);
    //实现视频播放位置切换，
//    [cbPlayerController seekTo:currentTIme];
    //两种方式都可以实现seek操作
//    [cbPlayerController setCurrentPlaybackTime:currentTIme];
}
- (void)onDragSlideStart:(id)sender {
    //    [self isLoadingView];
    
    [self stopTimer];//12
}

//视频文件完成初始化，开始播放视频并启动刷新timer。1
- (void)onpreparedListener: (NSNotification*)aNotification
{
    [self performSelectorOnMainThread:@selector(hiddenLoadingView) withObject:nil waitUntilDone:NO];
    [self startTimer];
}

- (void)hiddenLoadingView
{
//    _loadingView.hidden = YES;
}

//完成视频播放位置调整
- (void)seekComplete:(NSNotification*)notification
{
    ////NSLog(@"完成视频播放位置调整seekComplete--%@",[NSThread isMainThread]?@"isMainThread":@"Not mainThread");
    //    [self performSelectorOnMainThread:@selector(hiddenLoadingView) withObject:nil waitUntilDone:NO];
    [self startTimer];
}

//播放完成
- (void)playerBackDidFinish:(NSNotification *)notif
{
//    if (self.isLive) {
//        _loadingView.hidden = YES;
//        errorLab.hidden = NO;
//    }
}

//播放失败
- (void)playerBackError:(NSNotification *)notifa
{
    //    NSLog(@"播放失败playerBackError:%@-------%@---------%@",[notifa userInfo],[notifa object],[notifa name]);
//    errorLab.hidden = NO;
    [self performSelectorOnMainThread:@selector(hiddenLoadingView) withObject:nil waitUntilDone:NO];
}
//状态改变
- (void)stateDidChange:(NSNotification*)notif
{
    ////NSLog(@"播放状态发送改变stateDidChange--%@",[NSThread isMainThread]?@"isMainThread":@"Not mainThread");
//    if (self.isLive) {
        if(cbPlayerController.playbackState == CBPMoviePlaybackStatePaused){
            [cbPlayerController play];
        }
//    }
}
//缓冲过程
- (void)GotCachePercent:(NSNotification *)notific
{
    [self performSelectorOnMainThread:@selector(loadPercentOnMain:) withObject:[notific object] waitUntilDone:NO];
}

- (void)loadPercentOnMain:(id)sender
{
    if(100 == [sender intValue])
    {
//        [percentHub hide:YES];
    }else
    {
//        [self loadPercent:[sender intValue]];
    }
}
- (void)onClickPlay:(id)sender {
    //当按下播放按钮时，调用startPlayback方法
    [self startPlayback];
}

- (void)onClickStop:(id)sender {
    [self stopPlayback];
}
- (void)startPlayback{
    //    NSURL *url = [NSURL URLWithString:@"http://119.188.2.50/data2/video04/2013/04/27/00ab3b24-74de-432b-b703-a46820c9cd6f.mp4"];
//    NSString *playerUrl = @"http://3g3u8.imgo.tv/ac611a4e049a0314941411b13351dd9c/5441e904/phone/g/phone/sdzm/s1/140914sjjhd.mp4/playlist.m3u8";
//    NSURL *url = [NSURL URLWithString:playerUrl];
    NSURL *url = [NSURL URLWithString:self.playerURL];
    switch (cbPlayerController.playbackState) {
        case CBPMoviePlaybackStateStopped:
        case CBPMoviePlaybackStateInterrupted:
            [cbPlayerController setContentURL:url];
            //初始化完成后直接播放视频，不需要调用play方法
            cbPlayerController.shouldAutoplay = YES;
            //初始化视频文件
            [cbPlayerController prepareToPlay];
//            [startBtn setImage:[UIImage imageNamed:@"bofang_anniu@2x"] forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePlaying:
            //如果当前正在播放视频时，暂停播放。
            [cbPlayerController pause];
//            [startBtn setImage:[UIImage imageNamed:@"zanting_anniu@2x"] forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePaused:
            //如果当前播放视频已经暂停，重新开始播放。
            [cbPlayerController start];
//            [startBtn setImage:[UIImage imageNamed:@"bofang_anniu@2x"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)timerHandler:(NSTimer*)timer
{
    [self refreshProgress:cbPlayerController.currentPlaybackTime totalDuration:cbPlayerController.duration];
    //    [self refreshCurrentProgress:cbPlayerController.playableDuration totalDuration:cbPlayerController.duration];//当前可播放视频的长度4/6
    //    ////NSLog(@"timeHanler");
}

- (void)refreshProgress:(int) currentTime totalDuration:(int)allSecond{
    //    ////NSLog(@"refreshProgress");//4/7
//    NSInteger startT = self.startTimeInt + currentTime;//得到起始时间戳
    //    ////NSLog(@"currentTime:%d---allSecond:%d",currentTime,allSecond);
//    NSDictionary* dict = [[self class] convertSecond2HourMinuteSecond:startT];
//    NSString* strPlayedTime = [self getTimeString:dict prefix:@""];
//    currentProgress.text = strPlayedTime;
    //    ////NSLog(@"strPlayedTime:%@",strPlayedTime);
    //    ////NSLog(@"公共摄像头当前下载速度：%f",cbPlayerController.downloadSpeed);
    NSDictionary* dictLeft = [[self class] convertSecond2HourMinuteSecond:allSecond - currentTime];
    NSString* strLeft = [self getTimeString:dictLeft prefix:@"-"];
//    remainsProgress.text = strLeft;
//    slider.value = currentTime;
//    slider.maximumValue = allSecond;
}

+ (NSDictionary*)convertSecond2HourMinuteSecond:(int)second
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    int hour = 0, minute = 0;
    hour = second / 3600;
    minute = (second - hour * 3600) / 60;
    second = second - hour * 3600 - minute *  60;
    
    [dict setObject:[NSNumber numberWithInt:hour] forKey:@"hour"];
    [dict setObject:[NSNumber numberWithInt:minute] forKey:@"minute"];
    [dict setObject:[NSNumber numberWithInt:second] forKey:@"second"];
    return dict;
}

- (NSString*)getTimeString:(NSDictionary*)dict prefix:(NSString*)prefix
{
    int hour = [[dict objectForKey:@"hour"] intValue];
    int minute = [[dict objectForKey:@"minute"] intValue];
    int second = [[dict objectForKey:@"second"] intValue];
    
    NSString* formatter = hour < 10 ? @"0%d" : @"%d";
    NSString* strHour = [NSString stringWithFormat:formatter, hour];
    
    formatter = minute < 10 ? @"0%d" : @"%d";
    NSString* strMinute = [NSString stringWithFormat:formatter, minute];
    
    formatter = second < 10 ? @"0%d" : @"%d";
    NSString* strSecond = [NSString stringWithFormat:formatter, second];
    
    return [NSString stringWithFormat:@"%@%@:%@:%@", prefix, strHour, strMinute, strSecond];
}

- (void)startTimer{
    //为了保证UI播放进度刷新在主线程中完成
    ////NSLog(@"startTimer：isLive：%d",self.isLive);
//    if (_isLive) {
//        return;
//    }else
    {
        [self performSelectorOnMainThread:@selector(startTimeroOnMainThread) withObject:nil waitUntilDone:NO];
    }
    //    ////NSLog(@"公共摄像头当前下载速度：%f",cbPlayerController.downloadSpeed);
}

//缓冲完也会进这个函数
//只有这里主线程可以停掉loading
- (void)startTimeroOnMainThread{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    //    ////NSLog(@"公共摄像头当前下载速度：%f",cbPlayerController.downloadSpeed);3
}

- (void)stopTimer{
    if ([timer isValid])
    {
        [timer invalidate];
    }
//    if (_timer3 && [_timer3 isValid]) {
//        [_timer3 invalidate];
//    }
    timer = nil;
//    _timer3 = nil;
}

- (void)stopPlayback{
    //停止视频播放
    [cbPlayerController stop];
    [self stopTimer];
}

//返回
- (void)backAction
{
    [self stopPlayback];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//弹出或隐藏设置按钮
- (void)hiddenOrNo:(id)sender
{
    if (topViewHidden) {

        [UIView animateWithDuration:0.15 animations:^{
            topView.frame = CGRectMake(0, -44, kHeight, 44);
            bottomView.frame = CGRectMake(0, kWidth+60, kHeight, 60);
        }];
        topViewHidden = !topViewHidden;
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            topView.frame = CGRectMake(0, 0, kHeight, 44);
            bottomView.frame = CGRectMake(0, kWidth-60, kHeight, 60);
        }];
        topViewHidden = !topViewHidden;
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
