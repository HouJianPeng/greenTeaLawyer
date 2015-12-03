//
//  CaseModel.h
//  greenTeaUser
//
//  Created by Herron on 15/7/10.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CaseModel : NSManagedObject

@property (nonatomic, retain) NSString * caseId;
@property (nonatomic, retain) NSString * createTime;
@property (nonatomic, retain) NSString * caseNo;
@property (nonatomic, retain) NSString * caseName;
@property (nonatomic, retain) NSString * caseTitle;
@property (nonatomic, retain) NSString * districtId;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * businessType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * lawyerNum;
@property (nonatomic, retain) NSString * statusLabel;
@property (nonatomic, retain) NSString * businessTypeLabel;
@property (nonatomic, retain) NSString * descriptionStr;
@property (nonatomic, retain) NSString * cycleTime;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * reply;
@property (nonatomic, retain) NSString * disPlayName;

@end
