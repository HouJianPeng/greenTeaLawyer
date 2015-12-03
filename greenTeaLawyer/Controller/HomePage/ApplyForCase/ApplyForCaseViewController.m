//
//  ApplyForCaseViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ApplyForCaseViewController.h"
#import "EntrustDetailViewController.h"
#import "ApplyForCaseCell.h"
#import "NetWorkMacro.h"
#import "NetWork.h"
#import "AccountManager.h"
#import "CaseModel.h"
#import "CaseManager.h"
#import "LoginViewController.h"
#import "BusinessAreaTableViewController.h"
#import "MJRefresh.h"
static NSInteger page =1;
@interface ApplyForCaseViewController ()<BusinessTableViewControllerDelegate, UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *caseTableView;

@property (nonatomic, retain) NSMutableArray *caseArray;
@property (nonatomic, assign) int mark;
@property (nonatomic, retain) UIScrollView *businessAreaView;
@property (nonatomic, retain) NSArray *businessArray;
@property (nonatomic, retain) BusinessAreaTableViewController *businessVC;
@property(nonatomic,retain) NSString * types;
@end

@implementation ApplyForCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"案件委托";
    self.view.backgroundColor = [UIColor blackColor];
    self.caseTableView.backgroundColor = [UIColor blackColor];
    NSDictionary *dic1 = @{@"公司法律事务":@"A"};
    NSDictionary *dic2 = @{@"银行与金融":@"B"};
    NSDictionary *dic3 = @{@"公司收购、兼并与重组":@"C"};
    NSDictionary *dic4 = @{@"房地产与建筑工程":@"D"};
    NSDictionary *dic5 = @{@"知识产权":@"E"};
    NSDictionary *dic6 = @{@"劳动争议":@"F"};
    NSDictionary *dic7 = @{@"民商事合同诉讼与仲裁":@"G"};
    NSDictionary *dic8 = @{@"刑事案件":@"H"};
    NSDictionary *dic9 = @{@"证券与资本市场":@"R"};
    NSDictionary *dic10 = @{@"私募股权与投资基金":@"J"};
    
    
    self.businessArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10, nil];
    self.types = @"";
    self.mark = 0;
    
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"lv013"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(selectBusinessView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    self.caseArray = [NSMutableArray array];
    [self.caseTableView registerNib:[UINib nibWithNibName:@"ApplyForCaseCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [self.caseTableView setRowHeight:160];
    self.caseTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.caseTableView.showsVerticalScrollIndicator = NO;
    
    self.caseTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1;
        [self.caseTableView.header beginRefreshing];
        [self netWorkWithkeywords:self.types];
        [self.caseTableView.header endRefreshing];
    }];
    self.caseTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self.caseTableView.footer beginRefreshing];
        [self netWorkWithkeywords:self.types];
        [self.caseTableView.footer endRefreshing];
    }];
    
    [self netWorkWithkeywords:@""];
}

- (void)selectBusinessView:(UIButton *)sender
{
    NSLog(@"业务领域");
    
    if (self.mark == 0) { 
        self.businessVC = [[BusinessAreaTableViewController alloc] initWithStyle:UITableViewStylePlain];
        self.businessVC.delegate = self;
        
        [self.businessVC.view setFrame:CGRectMake(60, 0, self.view.frame.size.width - 60, self.view.frame.size.height - 49)];
        [self.view addSubview:self.businessVC.view];
        self.mark = 1;
        
        
    } else {
        
        [self.businessVC.view setFrame:CGRectMake(60, 0, 0, 0)];
        self.mark = 0;
    }
}

- (void)sendBusinessToCaseList:(NSString *)str
{
    NSLog(@"str = %@", str);
    self.types = str;
    page =1;
    [self netWorkWithkeywords:str];
    [self.caseTableView reloadData];
    [self.businessVC.view setFrame:CGRectMake(60, 0, 0, 0)];
    self.mark = 0;
    
}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)netWorkWithkeywords:(NSString *)keywords
{
    //        NSDictionary *dic = @{@"cosmosPassportId":userId, @"keywords":@"", @"page":@"1", @"pageSize":@"10000"};
    
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_LIST_BLOCK&cosmosPassportId=%@&businessType=%@&page=%ld&pageSize=%@",SERVER_HOST_PRODUCT, userId, keywords,(long)page,@"10"];
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [NetWork POST:urlString parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *array = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_LIST_BLOCK"] objectForKey:@"list"] firstObject];
        
        self.caseArray =[@[] mutableCopy];
        for (NSDictionary *dic in array) {
            [self.caseArray addObject:[CaseManager caseModelWithDict:dic]];
        }
        [self.caseTableView reloadData];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.caseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyForCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row % 2 == 0) {
        [cell setBackgroundColor:[UIColor darkGrayColor]];
    } else {
        [cell setBackgroundColor:[UIColor blackColor]];
    }
    CaseModel *model = [self.caseArray objectAtIndex:indexPath.row];
    NSLog(@"model = %@  %@", model.descriptionStr,model.caseTitle);
    cell.caseTitleLabel.text = model.caseTitle;
    [cell.caseTitleLabel setTextColor:[UIColor whiteColor]];
    cell.caseDetailLabel.text = model.descriptionStr;
    [cell.caseDetailLabel setTextColor:[UIColor whiteColor]];
    cell.caseTypeLabel.text = model.businessTypeLabel;
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"yes"]) {
        EntrustDetailViewController *entrustDetailViewController = [[EntrustDetailViewController alloc] init];
        CaseModel *model = [self.caseArray objectAtIndex:indexPath.row];
        entrustDetailViewController.caseId = model.caseId;
        [self.navigationController pushViewController:entrustDetailViewController animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未登录, 请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [AccountManager changeRootVCWithLogin];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
