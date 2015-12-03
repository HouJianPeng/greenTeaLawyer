//
//  MainViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MyTeaViewController.h"
#import "InfoViewController.h"
//#import "ConsultViewController.h"
#import "AboutMeViewController.h"
@interface MainViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MyTeaViewController *myTeaVC;
@property (nonatomic, strong) AboutMeViewController *consultVC;

@property (nonatomic, strong) UINavigationController *homeNavigation;
@property (nonatomic, strong) UINavigationController *myTeaNavigation;
@property (nonatomic, strong) UINavigationController *consultNavigation;

@property (nonatomic, strong) UIView *tf_tabBarView;

@end

@implementation MainViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    
    [self initTFViewController];
    
}

- (void)initTFTabBarView {
    self.tf_tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBoundHeight - 29, kScreenBoundWidth, 49)];
    self.tf_tabBarView.backgroundColor = RGBA(245, 245, 245, 1);
    UIView *barLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBoundWidth, 1)];
    [self.tf_tabBarView addSubview:barLine];
    
    
}

- (void)initTFViewController {
    
    self.homeVC = [[HomeViewController alloc] init];
    self.homeVC.view.backgroundColor = [UIColor grayColor];
    self.homeVC.title = @"首页";
    self.homeVC.tabBarItem.tag = 0;
    self.homeVC.tabBarItem.image = [UIImage imageNamed:@"Main_tabBar0"];
    self.homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Main_tabBar0"];
    
    self.myTeaVC = [[MyTeaViewController alloc] init];
    self.myTeaVC.title = @"我的绿茶";
    self.myTeaVC.tabBarItem.tag = 1;
    self.myTeaVC.tabBarItem.image = [UIImage imageNamed:@"main5"];
    self.myTeaVC.tabBarItem.selectedImage = [UIImage imageNamed:@"main5"];
    
    self.consultVC = [[AboutMeViewController alloc] init];
    self.consultVC.title = @"关于我们";
    self.consultVC.tabBarItem.tag = 2;
    self.consultVC.tabBarItem.image = [UIImage imageNamed:@"as_07"];
    self.consultVC.tabBarItem.selectedImage = [UIImage imageNamed:@"as_08"];
    
    self.homeNavigation = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    self.myTeaNavigation = [[UINavigationController alloc] initWithRootViewController:self.myTeaVC];
    self.consultNavigation = [[UINavigationController alloc] initWithRootViewController:self.consultVC];
    
    self.viewControllers = @[self.homeNavigation, self.myTeaNavigation, self.consultNavigation];
    self.selectedIndex = 0;
    self.tabBar.selectedImageTintColor = [UIColor redColor];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.title = item.title;
}



@end
