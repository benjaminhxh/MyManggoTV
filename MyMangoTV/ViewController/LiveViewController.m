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

@interface LiveViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    PaginationButton *button;
    UITableView *livetableView;
    NSArray *hnliveArray;
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
    livetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height)];
    livetableView.dataSource = self;
    livetableView.delegate = self;
    [self.view addSubview:livetableView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    title.text = @"直播";
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = 1;
    self.navigationItem.titleView = title;
    
    button = [[PaginationButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    button.numberOfButton =4;
    [button setTitle: @[@"卫视台",@"地方台",@"付费台",@"收藏"]];
    button.Selectedcolor = [UIColor orangeColor];
    button.Normalbgimage = [UIImage imageNamed:@"SegmentBackground.png"];
    button.Selectedbgimage = [UIImage imageNamed:@"SegmentBackgroundSelected.png"];
    button.selectedIndex = 0;
    button.didSelectedAtIndex = ^(PaginationButton *sender, NSInteger index){
        [livetableView reloadData];  //重新加载数据！！！
    };
    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData object:nil];
}

//刷新首页上面的滚动视图
- (void)didRefresh:(NSNotification *)notification
{
    hnliveArray = [[DVIDataManager sharedManager] hnliveData];
    [livetableView reloadData];
}

//表格的行数   1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
    
    if (button.selectedIndex == 0) {
        cell.name.text = @"湖南卫视";
        cell.label.text = @"暂无节目信息";
        cell.image.image =[UIImage imageNamed:@"0.jpg"];
        NSString *urlString = [NSString stringWithFormat:@"http://m.imgo.tv/json/phone//GetLive_SD.aspx?ClientName=IPhone&Type=HNTVLive"];
//        [self requestDataWith:urlString];
        [[AFHTTPRequestOperationManager manager] POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *downloadDict = (NSArray *)responseObject;
            NSDictionary *dict = [downloadDict objectAtIndex:indexPath.row];
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
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];

        
    }
    else if (button.selectedIndex == 1)
    {
        cell.name.text = @"节目啊节目";
        cell.label.text = @"没有节目信息";
        cell.image.image =[UIImage imageNamed:@"0.jpg"];
    }
    else if (button.selectedIndex == 2)
    {
        cell.name.text = @"3";
        cell.label.text = @"3";
        cell.image.image =[UIImage imageNamed:@"0.jpg"];
    }
    else if (button.selectedIndex == 3)
    {
        cell.name.text = @"4";
        cell.label.text = @"4";
        cell.image.image =[UIImage imageNamed:@"0.jpg"];
    }

    return cell;
}

//- (NSDictionary *)requestDataWith:(NSString *)url
//{
//    [[AFHTTPRequestOperationManager manager] POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        NSLog(@"dict:%@",dict);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    }];
//}
- (void)cliked:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
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
