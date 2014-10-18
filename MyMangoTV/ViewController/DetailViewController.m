//
//  DetailViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DetailViewController.h"

#import "PaginationButton.h"
#import "MyTableViewCell.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    PaginationButton *button;
}
@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-54)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 160)];
    tableView.tableHeaderView = headerView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIImageView *bigimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11.jpg"]];
    bigimage.frame = CGRectMake(10, 0, 90, 130);
    [headerView addSubview:bigimage];
    
    UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 30)];
    typelabel.text = @"类型：活动 生活 综艺";
    typelabel.font = [UIFont systemFontOfSize:14];
    typelabel.numberOfLines = 2;
    [headerView addSubview:typelabel];
    
    UILabel *chupinlabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 200, 30)];
    chupinlabel.text = @"出品方：湖南卫视";
    chupinlabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:chupinlabel];
    
    UILabel *publishTime = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, 200, 30)];
    publishTime.text = @"更新时间：2014-08-21";
    publishTime.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:publishTime];
    
    
    button = [[PaginationButton alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y +130, self.view.frame.size.width, 30)];
    button.numberOfButton =2;
    [button setTitle: @[@"整片",@"短片"]];
    button.Selectedcolor = [UIColor orangeColor];
    button.Normalbgimage = [UIImage imageNamed:@"SegmentBackground.png"];
    button.Selectedbgimage = [UIImage imageNamed:@"SegmentBackgroundSelected.png"];
    button.selectedIndex = 0;
    button.didSelectedAtIndex = ^(PaginationButton *sender, NSInteger index){
        [tableView reloadData];  //重新加载数据！！！
    };
    [headerView addSubview:button];
}

//表格的行数   1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

//3
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (button.selectedIndex == 0) {
        cell.image.image =[UIImage imageNamed:@"0.jpg"];
        cell.label.text = @"陆毅贝儿坐牛车被遗忘陆毅贝儿坐牛车被遗忘";
        cell.durlabel.text = @"00:02:08";
        cell.name.text = @"爸爸去哪儿 14-08-21";
    }
    else if (button.selectedIndex == 1)
    {
        cell.image.image =[UIImage imageNamed:@"1.jpg"];
        cell.label.text = @"《爸爸2》未播花絮：星爸萌娃对峙神奇摄像机";
        cell.durlabel.text = @"00:01:35";
        cell.name.text = @"爸爸去哪儿 14-08-13";
    }
    
    return cell;
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

@end
