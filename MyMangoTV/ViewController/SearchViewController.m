//
//  SearchViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width

#import "SearchViewController.h"

@interface SearchViewController ()
{
    UITextField *searchF;
}
@end

@implementation SearchViewController

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
    
//    self.view.backgroundColor = [UIColor magentaColor];
    searchF = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, kWidth-70, 40)];
    searchF.placeholder = @"请输入搜索关键词";
    searchF.borderStyle = UITextBorderStyleLine;
    self.navigationItem.titleView = searchF;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"TabBarHomeSearchSelectedIcon@2x"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(kWidth-50, 20, 40, 40);
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView addSubview:searchBtn];
    
}

- (void)searchBtnAction
{
    [searchF resignFirstResponder];
    NSString *searchURL = @"http://m.imgo.tv/json/phone//Search.aspx?flag=new&SearchKey=";
    if (searchF.text.length) {
        NSString *url = [searchURL stringByAppendingString:searchF.text];
        
    }
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
