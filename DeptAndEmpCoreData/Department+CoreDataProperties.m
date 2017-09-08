//
//  Department+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/5.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "Department+CoreDataProperties.h"

@implementation Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Department"];
}

@dynamic createDate;
@dynamic departmentId;
@dynamic departmentName;
@dynamic employee;

@end
