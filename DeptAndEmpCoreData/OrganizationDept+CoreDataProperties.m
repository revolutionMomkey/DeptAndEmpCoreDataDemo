//
//  OrganizationDept+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/7.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "OrganizationDept+CoreDataProperties.h"

@implementation OrganizationDept (CoreDataProperties)

+ (NSFetchRequest<OrganizationDept *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OrganizationDept"];
}

@dynamic name;
@dynamic orgId;
@dynamic costDept;
@dynamic semployee;

@end
