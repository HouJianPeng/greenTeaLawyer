//
//  BusinessTableViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessTableViewControllerDelegate <NSObject>

- (void)sendBusinessToCaseList:(NSString *)str;

@end


@interface BusinessTableViewController : UITableViewController

@property (nonatomic, assign) id<BusinessTableViewControllerDelegate> delegate;

@end
