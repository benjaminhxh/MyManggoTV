//
//  HomeViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "HomeViewController.h"

#import "CommonTableViewCell.h"

#import "MyScrollView.h"
#import "MyTipsView.h"
#import "HotView.h"

#import "UIImageView+WebCache.h"
#import "SVPullToRefresh.h"

#import "PublicHeader.h"
#import "Configuration.h"

#import "DVIDataManager.h"
#import "FlashItem.h"
#import "TypeCommendItem.h"
#import "VideoItem.h"
#import "PartItem.h"
#import "SpecialItem.h"
#import "PlayerViewController.h"
#import "AFNetworking.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, MyScrollViewDelegate, MyScrollViewDataSource>
{
    UITableView *homeTableView;
    
    MyScrollView *bannerView;
    UIPageControl *pageControl;
    
    MyTipsView *tipsView;
    NSTimer *timer;
    
    NSArray *bannerArray;
    NSArray *commendArray;
}
@end

@implementation HomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *)tableViewHeader
{
    CGRect rect = self.view.frame;
    CGFloat height = 170;
    CGFloat tipHeight = 24;
    CGFloat pageHeight = 15;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, height)];
    headerView.backgroundColor = [UIColor blackColor];
    
    //创建头部滚动视图
    bannerView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, height - tipHeight)];
    bannerView.dataSource = self;
    bannerView.delegate = self;
    [headerView addSubview:bannerView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - tipHeight - pageHeight, rect.size.width, pageHeight)];
    
//只在调试模式使用
#ifdef DEBUG
    pageControl.numberOfPages = 10;
#endif
    
    [headerView addSubview:pageControl];
    
    tipsView = [[MyTipsView alloc] initWithFrame:CGRectMake(0, height - tipHeight, rect.size.width, tipHeight)];
    tipsView.image = [UIImage imageNamed:@"HomeActivityBarIcon.png"];
    tipsView.backgroundColor = [UIColor colorWithRed:59.0/255 green:59.0/255 blue:59.0/255 alpha:1.0];
    [tipsView loadData:@[@"1", @"2", @"3", @"4"]];
    [headerView addSubview:tipsView];
    
    return headerView;
}

- (void)createTableView
{
    CGRect rect = self.view.frame;
    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 60) style:UITableViewStylePlain];
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    homeTableView.tableHeaderView = [self tableViewHeader];
    homeTableView.dataSource = self;
    homeTableView.delegate = self;
    [self.view addSubview:homeTableView];
    
    [homeTableView addPullToRefreshWithActionHandler:^{
        //强制刷新首页的数据
        [[DVIDataManager sharedManager] flashData:YES];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationBarLogo.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"PlayRecordsIcoGray.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickHistory:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData object:nil];
    
    //获取首页的数据
    [homeTableView triggerPullToRefresh];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(didClick:) userInfo:nil repeats:YES];
}

//刷新首页上面的滚动视图
- (void)didRefresh:(NSNotification *)notification
{
    bannerArray = [[DVIDataManager sharedManager] flashData: NO];
    [bannerView reloadData];
//    NSLog(@"bannaerArr:%@",bannerArray);
    commendArray = [[DVIDataManager sharedManager] commendData];
//    NSLog(@"commandArr:%@",commendArray);
    [homeTableView reloadData];
    
    [homeTableView.pullToRefreshView stopAnimating];
}

- (IBAction)didClick:(id)sender {
    [tipsView scrollTips];
}

- (void)didClickHistory:(id)sender
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return commendArray.count;
}

//2
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//4
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *hotIdentifier = @"hot";
//    static NSString *varietyIdentifier = @"variety";
    
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotIdentifier];
    if (cell == nil) {
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotIdentifier];
    }
    
    //获取每个section的数据
    TypeCommendItem *item = [commendArray objectAtIndex:indexPath.section];
    //获取section中subItem的数据
    NSArray *array = [item subItems];
//    NSLog(@"array:%@",array);
    //返回每个cell里面图片的个数
    cell.numberOfViewInCell = ^NSInteger(CommonTableViewCell *cCell){
        return array.count;
    };
    
    cell.widthForCell = ^CGFloat(CommonTableViewCell *cCell, NSInteger index){
        return 100.0f;
    };
    
    cell.viewForCell = ^(CommonTableViewCell *cCell, NSInteger index){
        HotView *v = [[HotView alloc] init];
        
        if (item.UiPartType == 3) {
            VideoItem *video = [array objectAtIndex:index];
//            NSLog(@"video.url:%@",video.PlayUrl);
            [v.imageView sd_setImageWithURL:[NSURL URLWithString:video.Pic]];
            v.label.text = video.Vname;
//            NSLog(@"video.Vname:%@",video.Vname);
        }
        else if(item.UiPartType == 4){
            PartItem *part = [array objectAtIndex:index];
            [v.imageView sd_setImageWithURL:[NSURL URLWithString:part.Pic]];
            v.label.text = part.Pname;
        }
        else if(item.UiPartType == 5){
            SpecialItem *special = [array objectAtIndex:index];
            [v.imageView sd_setImageWithURL:[NSURL URLWithString:special.Pic]];
            v.label.text = special.Sname;
        }
        
        return v;
    };
    
    //对于block里面使用外部的一些变量时，进行复制
    __weak typeof(self) weakSelf = self;
    cell.didSelectedView = ^(CommonTableViewCell *cCell, NSInteger index) {
        DetailViewController *detailCtrl = [[DetailViewController alloc] init];
        //当使用push显示的时候，隐藏下面的TabBar
        detailCtrl.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailCtrl animated:YES];
    };
    
    [cell reloadData];
    
    return cell;
}

//3
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TypeCommendItem *item = [commendArray objectAtIndex:indexPath.section];

    if (item.PicType == 2) {
        return 160;
    }
    
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{//添加section header
    TypeCommendItem *item = [commendArray objectAtIndex:section];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [control addTarget:self action:@selector(didClickSection:) forControlEvents:UIControlEventTouchUpInside];
    control.backgroundColor = [UIColor whiteColor];
    control.tag = section;
    
    UIView *oView = [[UIView alloc] initWithFrame:CGRectMake(8, 4, 4, 42)];
    oView.backgroundColor = [UIColor orangeColor];
    [control addSubview:oView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.view.frame.size.width - 20, 50)];
    label.font = [UIFont systemFontOfSize:32];
    label.textColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1.0];
    label.text = item.TypeName;
    label.font = [UIFont systemFontOfSize:14];
    [control addSubview:label];
    
    if (section % 2) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeMore.png"]];
        imageView.center = CGPointMake(self.view.frame.size.width - 20, 50 / 2);
        [control addSubview:imageView];
    }
    
    return control;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index.row:%d",indexPath.row);
}
- (void)didClickSection:(UIControl *)sender
{
    
    NSLog(@".....%d",sender.selected);
}

#pragma mark - MyScrollViewDataSource
- (NSInteger)numberOfPageInScrollView:(MyScrollView *)scrollView
{
    //
    return bannerArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *)scrollView:(MyScrollView *)scrollView viewAtIndex:(NSInteger)index
{
    FlashItem *item = [bannerArray objectAtIndex:index];
    
    UIImageView *v = [[UIImageView alloc] init];
    [v sd_setImageWithURL:[NSURL URLWithString:item.Pic]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180 - 24 - 50, self.view.frame.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.text = item.Name;
    [v addSubview:label];
    
    return v;
}

- (void)scrollView:(MyScrollView *)scrollView didSelectAtIndex:(NSInteger)index
{
    //点击头部滚动视图之后
    NSLog(@"selected: %d", index);
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];

    TypeCommendItem *item = [commendArray objectAtIndex:index];
    NSArray *array = [item subItems];
    NSLog(@"item.type:%d",item.UiPartType);
    if (item.UiPartType == 3) {
        VideoItem *video = [array objectAtIndex:index];
        NSLog(@"video.url:%@",video.PlayUrl);
        NSLog(@"video.Vname:%@",video.Vname);
        NSLog(@"video.PublishTime:%@",video.PublishTime);
        NSLog(@"video.SndlvlDesc:%@",video.SndlvlDesc);

        playerVC.playerTitle = video.Vname;
        NSLog(@"playTitle:%@",video.Vname);
        NSString *prefixURL = @"http://m.imgo.tv/json/phone//";
        NSString *playerURL = [prefixURL stringByAppendingString:video.PlayUrl];
        NSLog(@"playerURl:%@",playerURL);
        NSURL *url = [NSURL URLWithString:playerURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSString *urlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"url:%@",urlStr);
            playerVC.playerURL = urlStr;
            [self presentViewController:playerVC animated:YES completion:nil];

        }];
    }
}

- (void)scrollViewDidEndScroll:(MyScrollView *)scrollView
{
    pageControl.currentPage = scrollView.currentPage;
}
@end
