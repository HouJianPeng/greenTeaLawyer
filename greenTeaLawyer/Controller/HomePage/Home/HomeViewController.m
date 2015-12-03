//
//  HomeViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "HomeViewController.h"
#import "lawyerCatViewController.h"
#import "ConsultViewController.h"
#import "CaseConsignViewController.h"
#import "ApplyForCaseViewController.h"
#import "AccountManager.h"
#import "TFImagePlayerView.h"
#import "DetailInfoViewController.h"

#import "LoginViewController.h"
#import "MoreInfoViewController.h"
#import "HomePageTableViewCell.h"
#import "NewsInfoApiRequest.h"
#import "NewsModel.h"
#import "NewsVM.h"
#import "MJRefresh.h"
@interface HomeViewController ()<ImagePlayerViewDelegate, UITableViewDataSource, UITableViewDelegate, APIRequestDelegate>


@property(nonatomic,strong)IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *tableHeadView;

@property (weak, nonatomic) IBOutlet TFImagePlayerView *imagePlayer;

@property (weak, nonatomic) IBOutlet UIButton *applyCase;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

/// 最新资讯请求
@property (nonatomic, strong) NewsInfoApiRequest *apiRequestInfo;
/// 最新资讯数据
@property (nonatomic, strong) NSMutableArray *newsInfoArray;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.newsInfoArray = [NSMutableArray array];
    
    [self setupImageView];
    [self layoutPageSubviews];
    
    // 网络请求
    self.newsInfoArray = [NSMutableArray array];
    self.apiRequestInfo = [[NewsInfoApiRequest alloc] initWithDelegate:self];
    [self.apiRequestInfo setApiParamsWithPostName:@"1436840296083" PageLimit:@"3" CurrentPage:@"0"];
    [APIClient execute:self.apiRequestInfo];
}


- (void)layoutPageSubviews {
    
    [self.tableview registerNib:[HomePageTableViewCell nibWithHomePageCell] forCellReuseIdentifier:kHomePageTableViewCell];
    self.tableview.rowHeight = 95;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置titleView
    self.view.backgroundColor=[UIColor clearColor];//背景颜色
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];//初始化图片视图控件
    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    UIImage *image = [UIImage imageNamed:@"phone_icon"];//初始化图像视图
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView

    // 设置tableHeadView的高度
    CGFloat lunboHeight = kScreenBoundWidth / (200.0 / 131);
    CGFloat bgImageHeight = kScreenBoundWidth / (640.0 / 134);
    self.tableHeadView.height = lunboHeight + bgImageHeight;
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableview.header beginRefreshing];
        [self.tableview.header endRefreshing];
    }];
    self.tableview.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableview.footer beginRefreshing];
        [self.tableview.footer endRefreshing];
    }];
    
    // 设置tableFootView
    UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBoundWidth, 60)];
    CGFloat moreButtonWidth = kScreenBoundWidth - 20;
    CGFloat moreButtonHeight = 40;
    CGFloat moreButtonX = (kScreenBoundWidth - moreButtonWidth) / 2;
    CGFloat moreButtonY = (60 - moreButtonHeight) / 2;
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moreButton.frame = CGRectMake(moreButtonX, moreButtonY, moreButtonWidth, moreButtonHeight);
    [moreButton setBackgroundImage:[UIImage imageNamed:@"lv006"] forState:UIControlStateNormal];
    [tableFootView addSubview:moreButton];
    [moreButton bk_addEventHandler:^(id sender) {
        MoreInfoViewController *moreInfoVC = [[MoreInfoViewController alloc] init];
        [self.navigationController pushViewController:moreInfoVC animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableFooterView = tableFootView;

}

/**
 *  @brief  设置轮播图
 */
- (void)setupImageView
{
    self.imagePlayer.imagePlayerViewDelegate = self;
    
    self.imagePlayer.backgroundColor = [UIColor clearColor];
    self.imagePlayer.contentMode = UIViewContentModeScaleAspectFill;
    
    // set auto scroll interval to x seconds
    self.imagePlayer.scrollInterval = 3.0;
    
    // adjust pageControl position
    self.imagePlayer.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayer.hidePageControl = NO;
    
    // adjust edgeInset
    [self.imagePlayer reloadData];
    
    
}

#pragma mark - APIRequestDelegate

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(NSDictionary *)sr {
    
    if (api == self.apiRequestInfo) {
        NSArray *newsArray = sr[@"result"][@"scommerce"][@"LC_ADV_ADVERTISEMENT_LIST_BLOCK"][@"list"][0];
        for (NSDictionary *dict in newsArray) {
            NewsModel *model = [NewsVM newsModelWithDict:dict];
            [self.newsInfoArray addObject:model];
        }
        [self.tableview reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsInfoArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomePageTableViewCell forIndexPath:indexPath];
    
    NewsModel *model = [self.newsInfoArray objectAtIndex:indexPath.row];
    cell.tf_titleLabel.text = model.newsTitle;

    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", SERVER_IMAGE, model.picUrl];
    [cell.tf_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"firstImage"]];
    cell.tf_dateLabel.text = model.createTime;
    NSString *filterHtmlTagStr = [self filterHtmlTag:model.content]; // added by necaluo
    NSString *subStr = [NSString stringWithFormat:@"%@%@", [filterHtmlTagStr substringToIndex:40], @"..."];
    
    cell.tf_contentLabel.text = subStr;
    

    return cell;
}
- (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        //        NSLog(@"start-> %d   end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
        //        NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        // NSLog(@"Result--->%@", result);
        return [self filterHtmlTag:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
        //result = [originHtmlStr stringByReplacingOccurrencesOf  ........
    }
    return result;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消cell选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc]init];
    NewsModel *model = [self.newsInfoArray objectAtIndex:indexPath.row];
    detailVC.advertisementId = model.newsId;
    [self.navigationController pushViewController:detailVC animated:YES];

    NSLog(@"选中 %ld",(long)indexPath.row);
}



#pragma mark - ImagePlayerViewDelegate

/**
 *  Number of items
 *
 *  @return Number of items
 */
- (NSInteger)numberOfItems {
    return 3;
}

/**
 *  Init imageview
 *
 *  @param imagePlayerView ImagePlayerView object
 *  @param imageView       UIImageView object
 *  @param index           index of imageview
 */
- (void)imagePlayerView:(TFImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    NSString *imgStr = [NSString stringWithFormat:@"mm%@", @(index)];
    imageView.image = [UIImage imageNamed:imgStr];
}

#pragma mark - event response

-(IBAction)entrustbutn:(id)sender
{
    CaseConsignViewController*view =[[CaseConsignViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 申请接案
- (IBAction)applyCaseBtn:(id)sender {
    ApplyForCaseViewController *applyForCaseViewController = [[ApplyForCaseViewController alloc] init];
    [self.navigationController pushViewController:applyForCaseViewController animated:YES];
}

@end
