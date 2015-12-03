//
//  CaseConsignViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//
#import "CaseConsignViewController.h"
#import "NetWork.h"
#import "ZHPickView.h"
#import "AFNetworking.h"
#import "AccountManager.h"
#import "LoginViewController.h"
@interface CaseConsignViewController ()<ZHPickViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lowcaseId;
@property (weak, nonatomic) IBOutlet UITextField *businessType;
@property (weak, nonatomic) IBOutlet UIButton *submmitButton;
@property (weak, nonatomic) IBOutlet UITextField *caseTitle;
@property (weak, nonatomic) IBOutlet UITextView *thedescriptionLabel;
@property (weak, nonatomic) NSString *districtId;
@property (strong, nonatomic) ZHPickView*pickView;
@end
@implementation CaseConsignViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    self.title = @"案件委托";
    [self.submmitButton addTarget:self action:@selector(submmitTheValue) forControlEvents:UIControlEventTouchUpInside];
    self.businessType.delegate = self;
    _thedescriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _thedescriptionLabel.layer.borderWidth = 0.5;
    _thedescriptionLabel.layer.cornerRadius = 5;
    _thedescriptionLabel.layer.masksToBounds = YES;
}
#pragma mark 省份选择
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.businessType) {
        [self loadPickView];
    }
}
#pragma mark pickView 加载
-(void)loadPickView{
    _pickView =[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
    _pickView.delegate =self;
    [_pickView show];
}
#pragma mark 选择结果显示
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    self.businessType.text=resultString;
}
#pragma mark提交案件
-(void)submmitTheValue{
    if([AccountManager sharedInstance].isLogin)
    {
        if ([_lowcaseId.text isEqualToString:@""]) {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件编号不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else{
            [self pushTheModel];
        }
    }
    else{
        [AccountManager changeRootVCWithLogin];
    }
}
#pragma mark post发送数据
-(void)pushTheModel{
    NSDictionary *dict = @{@"cosmosPassportId":@"46c3a0cd22fd11e58136005056a87cbc", @"caseTitle": _caseTitle.text,@"businessType":_lowcaseId.text,@"description":_thedescriptionLabel.text,@"attachment":@"",@"districtId":@"7b6fefc9cb9711e3a770025041000001",@"street":@""};
    NSLog(@"%@",dict);
    NSString*url =[NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_SAVE_ACTION", SERVER_HOST_PRODUCT];
    [NetWork POST:url parmater:dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue]==0) {
                NSLog(@"提交失败");
            }
            else{
                NSLog(@"提交成功");
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
