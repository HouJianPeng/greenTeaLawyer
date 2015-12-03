//
//  LeftViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "LeftViewController.h"

@class MainViewController;
#import "MainViewController.h"
#import "AboutMeViewController.h"
#import "FeedBackViewController.h"
#import "RecommendViewController.h"
#import <MMDrawerController.h>

#import "MenuCell.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MMDrawerController *drawerVC;

@property (nonatomic, strong) AboutMeViewController *aboutVC;
@property (nonatomic, strong) FeedBackViewController *feedBackVC;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.drawerVC = (MMDrawerController *)kRootViewController;
    self.aboutVC = [[AboutMeViewController alloc] init];
    self.feedBackVC = [[FeedBackViewController alloc] init];
    

    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[MenuCell nibWithCell] forCellReuseIdentifier:kMenuCell];

//    self.tableView registerNib:<#(UINib *)#> forCellReuseIdentifier:<#(NSString *)#>

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCell forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        // 首页
        cell.lable.text = @"首页";
    } else if (indexPath.row == 1) {
        // 关于我们
        cell.lable.text = @"关于我们";
    } else if (indexPath.row == 2) {
        // 推荐
        cell.lable.text = @"推荐给好友";
    } else if (indexPath.row == 3) {
        // 意见反馈
        cell.lable.text = @"意见反馈";
    }
    
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu-0%ld", (indexPath.row + 1)]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 首页
        
    } else if (indexPath.row == 1) {
        // 关于我们
        
    } else if (indexPath.row == 2) {
        // 推荐
        
    } else if (indexPath.row == 4) {
        // 意见反馈
        
    }
}
@end
