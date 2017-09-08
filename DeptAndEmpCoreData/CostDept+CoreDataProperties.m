//
//  CostDept+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/7.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "CostDept+CoreDataProperties.h"

@implementation CostDept (CoreDataProperties)

+ (NSFetchRequest<CostDept *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CostDept"];
}

@dynamic costDeptId;
@dynamic name;
@dynamic organizationDept;
@dynamic semployee;

@end
