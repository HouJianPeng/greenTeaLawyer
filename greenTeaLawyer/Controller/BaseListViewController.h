//
//  BaseListViewController.h
//  DoctorYL
//
//  Created by 张玺 on 14/12/16.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//


#import "BaseViewController.h"

@interface BaseListViewController : BaseViewController

/**
 *  加载数据的页码
 */
@property (nonatomic, assign) NSInteger requestCurrentPage;

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  是否可以下拉刷新
 */
@property (nonatomic, assign) BOOL pullDownRefresh;

/**
 *  是否可以上拉加载更多
 */
@property (nonatomic, assign) BOOL loadMoreRefresh;

- (void)setRefreshView:(UIScrollView *)scrollView;

/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;

- (void)startPullDownRefreshing;
- (void)endPullDownRefreshing;
- (void)startLoadMoreRefreshing;
- (void)endLoadMoreRefreshing;

@end
