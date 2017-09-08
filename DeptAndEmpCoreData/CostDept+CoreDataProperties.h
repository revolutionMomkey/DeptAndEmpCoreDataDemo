//
//  CostDept+CoreDataProperties.h
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/7.
//  Copyright © 2017年 杜俊楠. All rights reserved.
//

#import "CostDept+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CostDept (CoreDataProperties)

+ (NSFetchRequest<CostDept *> *)fetchRequest;

@property (nonatomic) int16_t costDeptId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<OrganizationDept *> *organizationDept;
@property (nullable, nonatomic, retain) SEmployee *semployee;

@end

@interface CostDept (CoreDataGeneratedAccessors)

- (void)addOrganizationDeptObject:(OrganizationDept *)value;
- (void)removeOrganizationDeptObject:(OrganizationDept *)value;
- (void)addOrganizationDept:(NSSet<OrganizationDept *> *)values;
- (void)removeOrganizationDept:(NSSet<OrganizationDept *> *)values;

@end

NS_ASSUME_NONNULL_END
