//
//  InCaseViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InCaseViewController.h"
#import "CaseManager.h"

@interface InCaseViewController ()

@property (nonatomic, retain) NSDictionary *caseDic;

@end

@implementation InCaseViewController

- (void)viewDidLoad {
    self.caseDic = [NSDictionary dictionary];
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    self.title = @"案件详情";

    [self.myReplyTextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.myReplyTextView.layer setBorderWidth:0.5];
    [self.myReplyTextView.layer setCornerRadius:5];
    [self.myReplyTextView.layer setMasksToBounds:YES];
    
    self.caseTitleLabel.text = self.caseTitle;
    self.caseNumLabel.text = self.caseNumber;
    self.caseTypeLabel.text = self.caseType;
    self.caseDetailLabel.text = self.caseDetail;
    self.caseStateLabel.text = self.caseState;

    [self netWork2];
}



- (void)netWork2
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
//    NSDictionary *dic = @{@"cosmosPassportId":userId, @"lawcaseId":self.caseId};
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWYERCASE_GET_BLOCK&cosmosPassportId=%@&lawcaseId=%@",SERVER_HOST_PRODUCT, userId,self.caseId];
    
    NSLog(@"url = %@", url);
    
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        self.caseDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWYERCASE_GET_BLOCK"] objectForKey:@"list"] firstObject] firstObject];
        
        CaseModel *model = [CaseManager caseModelWithDict:self.caseDic];
        
        self.myReplyTextView.text = model.reply;
        self.moneyLabel.text = model.price;
        self.timeLabel.text = model.cycleTime;
        
    }];
}


- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
