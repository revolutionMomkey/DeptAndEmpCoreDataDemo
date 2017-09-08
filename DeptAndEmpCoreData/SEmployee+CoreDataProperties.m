//
//  SEmployee+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/7.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "SEmployee+CoreDataProperties.h"

@implementation SEmployee (CoreDataProperties)

+ (NSFetchRequest<SEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SEmployee"];
}

@dynamic name;
@dynamic stuffId;
@dynamic costDept;
@dynamic organizationDept;

@end
