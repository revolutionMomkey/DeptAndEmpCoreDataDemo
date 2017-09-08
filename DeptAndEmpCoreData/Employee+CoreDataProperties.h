//
//  Employee+CoreDataProperties.h
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/5.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sectionName;
@property (nullable, nonatomic, retain) Department *department;

@end

NS_ASSUME_NONNULL_END
