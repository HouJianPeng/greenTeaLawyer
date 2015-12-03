//
//  LawyerRegistViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/23.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawyerRegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField; // 姓名
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;  // 性别
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField; // 身份证号
@property (weak, nonatomic) IBOutlet UITextField *practiceNumTextField; // 执业证号
@property (weak, nonatomic) IBOutlet UITextField *institutionTextField; // 执业机构
@property (weak, nonatomic) IBOutlet UITextField *releaseDateTextField; // 发证日期
@property (weak, nonatomic) IBOutlet UITextField *licensedTypeTextField; // 执业证类型
@property (weak, nonatomic) IBOutlet UITextField *issuingTextField; // 发证机关
@property (weak, nonatomic) IBOutlet UITextField *businessTypeTextField; // 业务领域

@property (nonatomic, copy)NSString *phoneNumber;  // 手机号
@property (nonatomic, copy)NSString *password;     // 密码
@property (nonatomic, copy)NSString *verification; // 验证码
@property (nonatomic, copy)NSString *userType;     // 账户类型





@end
