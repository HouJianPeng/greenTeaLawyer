//
//  CaseModel.m
//  greenTeaUser
//
//  Created by Herron on 15/7/10.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "CaseModel.h"


@implementation CaseModel

@dynamic caseId;
@dynamic createTime;
@dynamic caseNo;
@dynamic caseName;
@dynamic caseTitle;
@dynamic districtId;
@dynamic street;
@dynamic userId;
@dynamic businessType;
@dynamic name;
@dynamic mobile;
@dynamic lawyerNum;
@dynamic statusLabel;
@dynamic businessTypeLabel;
@dynamic descriptionStr;
@dynamic price;
@dynamic reply;
@dynamic cycleTime;
@dynamic disPlayName;

- (NSString *)description
{
    return [NSString stringWithFormat:@"caseId = %@\ncaseNo = %@\ncaseTitle = %@\ndistrictId = %@\nbusinessType = %@\nname = %@\nbussinessTypeLabel = %@\ndescriptionStr = %@", self.caseId, self.caseNo, self.caseTitle, self.districtId, self.businessType, self.name, self.businessTypeLabel, self.descriptionStr];
}

@end
