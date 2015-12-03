//
//  EntrustDetailViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "EntrustDetailViewController.h"
#import "ApplyCaseViewController.h"
#import "NetWork.h"
#import "NetWorkMacro.h"
#import "CaseManager.h"

@interface EntrustDetailViewController ()

@property (nonatomic, assign) BOOL isPickUpOK;
@property (nonatomic, retain) NSString *infoStr;

@end

@implementation EntrustDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"案件详情";
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self netWork];
}

- (void)netWork
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    if (userId) {
        
//        NSDictionary *dic = @{@"cosmosPassportId":userId, @"lawcaseId":self.caseId};
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_GET_BLOCK&cosmosPassportId=%@&lawcaseId=%@", SERVER_HOST_PRODUCT, userId,self.caseId];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", myDic);
            
            NSDictionary *dic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_GET_BLOCK"] objectForKey:@"list"] firstObject] firstObject];
            
            CaseModel *model = [CaseManager caseModelWithDict:dic];
            
            NSString *timeStr = [model.createTime substringWithRange:NSMakeRange(0, 10)];
            self.caseTitleTextField.text = model.caseTitle;
            self.caseTimeTextField.text = timeStr;
            self.casePersonTextField.text = model.disPlayName;
            NSString *numberStr = [model.mobile substringToIndex:8];
            self.phoneNumTextField.text = numberStr;
            self.caseTypeTextField.text = model.businessTypeLabel;
            //self.phoneNumTextField.text = model.mobile;
            self.descriptionTextView.text = model.descriptionStr;
        }];
        
    }else {
        NSLog(@"用户未登录");
    }
}


- (IBAction)applyCaseClick:(id)sender
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSDictionary *dic = @{@"lawcaseId":self.caseId,@"cosmosPassportId":userId};
    
    [NetWork POST:PickUpCaseYesOrNOURL parmater:dic Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *dic = [[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_VERIFY_ACTION"] objectForKey:@"object"];
        NSNumber *success = (NSNumber *)[dic objectForKey:@"success"];
        self.infoStr = [dic objectForKey:@"info"];
        
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]] )
        {
            NSLog(@"审核通过，可以接案");
            ApplyCaseViewController *applyCaseViewController = [[ApplyCaseViewController alloc] init];
            applyCaseViewController.caseId = self.caseId;
            [self.navigationController pushViewController:applyCaseViewController animated:YES];
          
        }else if ([success isEqualToNumber:[NSNumber numberWithInt:0]]){
          
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:_infoStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }];
}



- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
