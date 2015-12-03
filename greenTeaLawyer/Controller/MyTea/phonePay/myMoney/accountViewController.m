//
//  accountViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/30.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "accountViewController.h"
#import "PhoneViewController.h"
@interface accountViewController ()

@end

@implementation accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的账户";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];

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

- (IBAction)chongzhiBtn:(id)sender {
    NSLog(@"充值");
    NSLog(@"%@",self.navigationController);
    PhoneViewController *phoneVC = [[PhoneViewController alloc]init];
    [self.navigationController pushViewController:phoneVC animated:YES];
    
}
@end
