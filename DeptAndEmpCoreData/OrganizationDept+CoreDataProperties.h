//
//  OrganizationDept+CoreDataProperties.h
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/7.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "OrganizationDept+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrganizationDept (CoreDataProperties)

+ (NSFetchRequest<OrganizationDept *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t orgId;
@property (nullable, nonatomic, retain) NSSet<CostDept *> *costDept;
@property (nullable, nonatomic, retain) SEmployee *semployee;

@end

@interface OrganizationDept (CoreDataGeneratedAccessors)

- (void)addCostDeptObject:(CostDept *)value;
- (void)removeCostDeptObject:(CostDept *)value;
- (void)addCostDept:(NSSet<CostDept *> *)values;
- (void)removeCostDept:(NSSet<CostDept *> *)values;

@end

NS_ASSUME_NONNULL_END
