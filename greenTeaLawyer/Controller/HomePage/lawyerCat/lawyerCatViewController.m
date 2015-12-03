//
//  lawyerCatViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "lawyerCatViewController.h"
#import "ConsultViewController.h"
@interface lawyerCatViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation lawyerCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"律师直通车";
    _tableview.separatorStyle=NO;//分割线
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

- (IBAction)chatBtn:(id)sender {
    NSLog(@"立即咨询");
    ConsultViewController *OnlineVC = [[ConsultViewController alloc]init];
    [self.navigationController pushViewController:OnlineVC animated:YES];
}
@end
