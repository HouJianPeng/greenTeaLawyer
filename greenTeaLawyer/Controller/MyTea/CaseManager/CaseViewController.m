//
//  CaseViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "CaseViewController.h"
#import "CaseTableViewCell.h"
#import "InCaseViewController.h"
#import "NetWork.h"
#import "NetWorkMacro.h"
#import "Account.h"
#import "AccountManager.h"
#import "CaseManager.h"
#import "MJRefresh.h"
static NSInteger page =1;
#define KCaseReuse @"CaseTableViewCellReuse"
@interface CaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *caseTableView;
@property (nonatomic, strong) NSMutableArray *caseArray;

@end

@implementation CaseViewController

- (void)viewDidLoad {
    
    
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

    // Do any additional setup after loading the view from its nib.
    self.title = @"案件管理";
    //注册cell
    [self.caseTableView registerNib:[UINib nibWithNibName:@"CaseTableViewCell" bundle:nil] forCellReuseIdentifier:KCaseReuse];
    self.caseTableView.rowHeight = 220;
    [self network];
    self.caseTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.caseTableView.footer beginRefreshing];
        if (self.caseArray.count==10) {
            page++;
        }
        [self network];
        [self.caseTableView.footer endRefreshing];
    }];
    self.caseTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.caseTableView.header beginRefreshing];
        page=1;
        [self network];
        [self.caseTableView.header endRefreshing];
    }];


}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - network
- (void)network
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
  //  NSDictionary *dic = @{@"cosmosPassportId":userId, @"keywords":@"", @"page":@"1",@"pageSize":@"100000000"};
    
    NSString *url = [NSString stringWithFormat:@"http://www.lawcheck.com.cn//cosmos.json?command=scommerce.LC_CASE_LAWCASE_LIST4USER_BLOCK&cosmosPassportId=%@&keywords=%@&page=%ld&pageSize=%@",userId,@"",page,@"10"];
        [NetWork GET:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *array = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_LIST4USER_BLOCK"] objectForKey:@"list"] firstObject];
            self.caseArray = [NSMutableArray array];

        for (NSDictionary *dic in array) {
            CaseModel *caseModel = [CaseManager caseModelWithDict:dic];
            [self.caseArray addObject:caseModel];
        }
        NSLog(@"%@", self.caseArray);
            if (self.caseArray.count!=0) {
                [self.caseTableView reloadData];
            }
        
    }];
}


#pragma mark  tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.caseArray count];
}
#pragma mark TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCaseReuse];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    CaseModel *model = [self.caseArray objectAtIndex:indexPath.section];
    cell.caseStateLabel.text = model.statusLabel;
    cell.caseTitleLabel.text = model.caseTitle;
    cell.caseDetailLabel.text = model.descriptionStr;
    cell.theDetialButton.tag = indexPath.section+100;
    [cell.theDetialButton addTarget:self action:@selector(pushTheNextView:)
                   forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)pushTheNextView:(UIButton*)button{
    CaseModel *model = [self.caseArray objectAtIndex:button.tag-100];
    InCaseViewController *incaseVC = [[InCaseViewController alloc]init];
    incaseVC.caseId = model.caseId;
    incaseVC.caseTitle = model.caseTitle;
    incaseVC.caseNumber = model.caseNo;
    incaseVC.caseType = model.businessTypeLabel;
    incaseVC.caseDetail = model.descriptionStr;
    incaseVC.caseState = model.statusLabel;
    [self.navigationController pushViewController:incaseVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
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
