//
//  AccountManager.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountManager : NSObject

@property (nonatomic, strong) Account *account;
@property (nonatomic, readonly) BOOL isLogin;

+ (AccountManager *)sharedInstance;
- (void)saveAccountInfoToDisk;
- (void)loadAccountInfoFromDisk;

+ (void)changeRootVCWithMMDrawer;
+ (void)changeRootVCWithLogin;
@end
