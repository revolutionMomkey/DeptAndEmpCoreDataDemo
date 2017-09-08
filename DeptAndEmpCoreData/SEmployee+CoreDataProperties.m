//
//  SEmployee+CoreDataProperties.m
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/7.
//  Copyright © 2017年 杜俊楠. All rights reserved.
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
