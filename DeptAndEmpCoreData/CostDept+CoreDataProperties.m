//
//  CostDept+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/7.
//  Copyright © 2017年 杜俊楠. All rights reserved.
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
