//
//  SEmployee+CoreDataProperties.h
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/7.
//  Copyright © 2017年 杜俊楠. All rights reserved.
//

#import "SEmployee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SEmployee (CoreDataProperties)

+ (NSFetchRequest<SEmployee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t stuffId;
@property (nullable, nonatomic, retain) CostDept *costDept;
@property (nullable, nonatomic, retain) OrganizationDept *organizationDept;

@end

NS_ASSUME_NONNULL_END
