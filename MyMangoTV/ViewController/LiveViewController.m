//
//  LiveViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//
#define kChannelName @"ChannelName"
#define kCurrentProgrom @"CurrentProgrom"
#define kProgromName  @"ProgromName"
#define kTime @"Time"
#define kPic  @"Pic"
#define kPlayUrl @"PlayUrl"

#import "LiveViewController.h"
#import "PaginationButton.h"
#import "LiveTableViewCell.h"

#import "DVIDataManager.h"
#import "Configuration.h"

#import "hntvLivItem.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "PlayerViewController.h"

@interface LiveViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    PaginationButton *button;
    UITableView *livetableView;
    NSArray *hnliveArray;
    NSArray *channelListURLArr;
    NSArray *downloadArr;
}

@end

@implementation LiveViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 84)];
    title.text = @"直播";
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = 1;
    self.navigationItem.titleView = title;
    channelListURLArr = [NSArray arrayWithObjects:
                         @"http://m.imgo.tv/json/phone//GetLive_SD.aspx?ClientName=IPhone&Type=HNTVLive",
                         @"http://m.imgo.tv/json/phone//GetLive_SD.aspx?ClientName=IPhone&Type=OtherLive",
                         @"http://m.imgo.tv/json/phone//GetLive_SD.aspx?ClientName=IPhone&Type=PayLive",
                         @"http://m.imgo.tv/json/phone//GetLive_SD.aspx?ClientName=IPhone&Type=HNTVLive",
                          nil];
    button = [[PaginationButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    button.numberOfButton =4;
    [button setTitle: @[@"卫视台",@"地方台",@"付费台",@"收藏"]];
    button.Selectedcolor = [UIColor orangeColor];
    button.Normalbgimage = [UIImage imageNamed:@"SegmentBackground.png"];
    button.Selectedbgimage = [UIImage imageNamed:@"SegmentBackgroundSelected.png"];
    button.selectedIndex = 0;
    [self requestDataWithIndex:0];
    button.didSelectedAtIndex = ^(PaginationButton *sender, NSInteger index){
        [self requestDataWithIndex:index];
    };
    [self.view addSubview:button];
    
    livetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40)];
    livetableView.dataSource = self;
    livetableView.delegate = self;
    [self.view addSubview:livetableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData object:nil];
}

//刷新首页上面的滚动视图
- (void)didRefresh:(NSNotification *)notification
{
    hnliveArray = [[DVIDataManager sharedManager] hnliveData];
    [livetableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//表格的行数   1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (downloadArr.count) {
        return downloadArr.count;
    }
    return 0;
}

//3
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.button setImage:[UIImage imageNamed:@"LivePlayButton.png"] forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(cliked:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    NSDictionary *dict = [downloadArr objectAtIndex:indexPath.row];
    cell.name.text = [dict objectForKey:kChannelName];
    NSArray *CurrentProgromArr = [dict objectForKey:kCurrentProgrom];
    if (CurrentProgromArr.count) {
        cell.label.text = [[CurrentProgromArr objectAtIndex:0] objectForKey:kProgromName];
        
    }else
    {
        cell.label.text = @"暂无节目信息";
    }
    NSString *imageUrl = [dict objectForKey:kPic];
    [cell.image setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell;
}

//请求直播频道列表
- (void)requestDataWithIndex:(int)index
{
    NSString *urlString = [channelListURLArr objectAtIndex:index];
    [[AFHTTPRequestOperationManager manager] POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        downloadArr = (NSArray *)responseObject;
        [livetableView reloadData];  //重新加载数据！！！
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
- (void)cliked:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    NSDictionary *dict = [downloadArr objectAtIndex:sender.tag];
//    NSLog(@"dict:%@",dict);
    NSString *url = [dict objectForKey:kPlayUrl];
//    NSLog(@"playurl:%@",url);
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];
    playerVC.playerURL = url;
    playerVC.playerTitle = [dict objectForKey:kChannelName];
    [self presentViewController:playerVC animated:YES completion:nil];
}

//设置cell高度  2  5
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%d",indexPath.row);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
