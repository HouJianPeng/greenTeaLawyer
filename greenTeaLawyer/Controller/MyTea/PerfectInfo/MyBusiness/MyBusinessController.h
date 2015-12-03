//
//  MyBusinessController.h
//  greenTeaLawyer
//
//  Created by 侯建鹏 on 15/11/16.
//  Copyright © 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BaseViewController.h"
//我的业务领域
@interface MyBusinessController : BaseViewController

@property (nonatomic, copy) NSString *myBusinessStr;
@property (weak, nonatomic) IBOutlet UITextView *myBusines;
@property(nonatomic, retain) NSArray *infoArray;
@property(nonatomic,strong)NSDictionary  * dic ;
@end
