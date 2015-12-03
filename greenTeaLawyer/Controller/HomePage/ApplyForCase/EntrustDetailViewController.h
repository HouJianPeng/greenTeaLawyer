//
//  EntrustDetailViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntrustDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *caseTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *caseTimeTextField;
@property (weak, nonatomic) IBOutlet UILabel *casePersonTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UILabel *caseTypeTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@property (nonatomic, retain) NSString *caseId; // 案件ID

@end
