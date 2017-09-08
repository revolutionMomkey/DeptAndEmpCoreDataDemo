//
//  Employee+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/5.
//  Copyright © 2017年 杜俊楠. All rights reserved.
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
}

@dynamic age;
@dynamic birthday;
@dynamic name;
@dynamic sectionName;
@dynamic department;

@end
