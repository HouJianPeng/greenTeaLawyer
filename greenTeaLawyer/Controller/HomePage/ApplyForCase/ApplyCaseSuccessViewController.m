//
//  ApplyCaseSuccessViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ApplyCaseSuccessViewController.h"
#import "ApplyForCaseViewController.h"
#import "CaseViewController.h"


@interface ApplyCaseSuccessViewController ()

@end

@implementation ApplyCaseSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"案件发布成功";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
   
    
    // Do any additional setup after loading the view from its nib.
}





- (IBAction)applyAnotherClick:(id)sender {
    ApplyForCaseViewController *applyCaseVC = [[ApplyForCaseViewController alloc] init];
    [self.navigationController pushViewController:applyCaseVC animated:YES];
}


- (IBAction)turnToCaseManagerClick:(id)sender {
    CaseViewController *caseVC = [[CaseViewController alloc] init];
    [self.navigationController pushViewController:caseVC animated:YES];
}




- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
