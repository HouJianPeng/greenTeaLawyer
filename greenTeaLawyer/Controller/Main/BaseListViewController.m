//
//  BaseListViewController.m
//  DoctorYL
//
//  Created by 张玺 on 14/12/16.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "BaseListViewController.h"
#import "RefreshControl.h"
#import "RefreshView.h"

@interface BaseListViewController ()<RefreshControlDelegate>
@property (nonatomic, strong)RefreshControl *refreshControl;
@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
}

- (void)setRefreshView:(UIScrollView *)scrollView {
    self.refreshControl = [[RefreshControl alloc] initWithScrollView:scrollView delegate:self];
    self.refreshControl.topEnabled = YES;
}

-(void)setPullDownRefresh:(BOOL)pullDownRefresh {
    _pullDownRefresh = pullDownRefresh;
    self.refreshControl.topEnabled = pullDownRefresh;
}

- (void)setLoadMoreRefresh:(BOOL)loadMoreRefresh {
    _loadMoreRefresh = loadMoreRefresh;
    self.refreshControl.bottomEnabled = loadMoreRefresh;
}

- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop) {
        self.requestCurrentPage = 1;
        [self loadDataSource];
    } else {
        self.requestCurrentPage++;
        [self loadDataSource];
    }
}

- (void)loadDataSource {
    //需要子类实现
}

- (void)startPullDownRefreshing {
    [self.refreshControl startRefreshingDirection:RefreshDirectionTop];
}

- (void)endPullDownRefreshing {
    [self.refreshControl finishRefreshingDirection:RefreshDirectionTop];
}

- (void)startLoadMoreRefreshing {
    [self.refreshControl startRefreshingDirection:RefreshDirectionBottom];
}

- (void)endLoadMoreRefreshing {
    [self.refreshControl finishRefreshingDirection:RefreshDirectionBottom];
}



@end
