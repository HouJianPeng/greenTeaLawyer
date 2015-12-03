//
//  ApplyCaseSuccessViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseModel.h"
@interface ApplyCaseSuccessViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *caseID;

@property (strong, nonatomic) CaseModel *caseModel; // 案件对象
@property (nonatomic, retain) NSString *caseId; // 案件ID
@end
