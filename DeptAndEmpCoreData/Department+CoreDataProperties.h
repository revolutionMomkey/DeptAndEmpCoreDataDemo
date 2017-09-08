//
//  Department+CoreDataProperties.h
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/5.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nonatomic) int16_t departmentId;
@property (nullable, nonatomic, copy) NSString *departmentName;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employee;

@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet<Employee *> *)values;
- (void)removeEmployee:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
