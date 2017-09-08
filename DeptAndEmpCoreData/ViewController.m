//
//  ViewController.m
//  DeptAndEmpCoreData
//
//  Created by dododo on 2017/9/4.
//  Copyright © 2017年 dododo. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee+CoreDataClass.h"
#import "Department+CoreDataClass.h"

#import "OrganizationDept+CoreDataClass.h"
#import "CostDept+CoreDataClass.h"
#import "SEmployee+CoreDataClass.h"

#import "DeptAndCostModelViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    //员工增删改查
    for (NSInteger i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.frame = CGRectMake(60*i+100, 50, 40, 40);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        switch (i) {
            case 0:{
                [btn setTitle:@"增" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 1:{
                [btn setTitle:@"查" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(readAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 2:{
                [btn setTitle:@"改" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 3:{
                [btn setTitle:@"删" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchDown];
            }break;
            default:
                break;
        }
        [self.view addSubview:btn];
    }

    //部门增删改查
    for (NSInteger i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.frame = CGRectMake(60*i+100, 250, 40, 40);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        switch (i) {
            case 0:{
                [btn setTitle:@"部增" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(addAction2) forControlEvents:UIControlEventTouchDown];
            }break;
            case 1:{
                [btn setTitle:@"部查" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(readAction2) forControlEvents:UIControlEventTouchDown];
            }break;
            case 2:{
                [btn setTitle:@"部改" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(updateAction2) forControlEvents:UIControlEventTouchDown];
            }break;
            case 3:{
                [btn setTitle:@"部删" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(deleteAction2) forControlEvents:UIControlEventTouchDown];
            }break;
            default:
                break;
        }
        [self.view addSubview:btn];
    }
    */
    
    //行政分组增加，结算分组增加，人员表增加，下一页
    for (NSInteger i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.frame = CGRectMake(80*i+40, 400, 60, 40);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        switch (i) {
            case 0:{
                [btn setTitle:@"DeptAdd" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(DeptAddAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 1:{
                [btn setTitle:@"CostAdd" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(CostAddAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 2:{
                [btn setTitle:@"EmpAdd" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(EmpAddAction) forControlEvents:UIControlEventTouchDown];
            }break;
            case 3:{
                [btn setTitle:@"NextPg" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(nextPgAction) forControlEvents:UIControlEventTouchDown];
            }break;
            default:
                break;
        }
        [self.view addSubview:btn];
    }
    
    
    /*
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"DeptAndEmpCoreData" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *persistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Company"];
    [persistent addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    self.context.persistentStoreCoordinator = persistent;
    */
    
    
    
    //本文中含有两个实体文件，如果你是来看多表关联的忽视掉注释的代码即可
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"DeptAndCostModel" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSPersistentStoreCoordinator *persistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingFormat:@"/%@.sqlite",@"DeptAndCost"];
    [persistent addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    
    self.context.persistentStoreCoordinator = persistent;


}



- (void)addAction {

    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    emp.name = @"1号员工";
    emp.birthday = [NSDate date];
    emp.age = 16;
    emp.sectionName = @"部门1";
    
    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Department"];
    fet.predicate = [NSPredicate predicateWithFormat:@"departmentName = %@",@"部门1"];
    NSArray *depts = [self.context executeFetchRequest:fet error:nil];
    
    emp.department = [depts firstObject];
    
    NSError *selfError = nil;
    if (self.context.hasChanges) {
        [self.context save:&selfError];
    }
    
    // 错误处理
    if (selfError) {
        NSLog(@"CoreData Insert Data Error : %@", selfError);
    }
}

- (void)readAction {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    NSError *error = nil;
    
    NSArray *employees = [self.context executeFetchRequest:request error:&error];
    
//    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"Employee Name : %@, Height : %hd, Brithday : %@", obj.name, obj.age, obj.birthday);
//    }];

    for (Employee *emp in employees) {
//        NSLog(@"%@",emp);
        NSLog(@"Employee Name:%@, age:%hd, Brithday:%@, sectionName:%@, department:%@", emp.name, emp.age, emp.birthday, emp.sectionName, emp.department);
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    
    
}

- (void)updateAction {
    
    NSFetchRequest *fet = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    
    // 创建谓词对象，设置过滤条件
    fet.predicate = [NSPredicate predicateWithFormat:@"name = %@",@"1号员工"];
    
    NSError *error = nil;
    NSArray *employees = [self.context executeFetchRequest:fet error:&error];
    
    for (Employee *emp in employees) {
        emp.sectionName = @"666";
    }
    
    // 将上面的修改进行存储
    if (self.context.hasChanges) {
        [self.context save:nil];
    }

    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
}

- (void)deleteAction {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@",@"1号员工"];
    
    NSError *error = nil;
    
    NSArray *employees = [self.context executeFetchRequest:request error:&error];
    
    for (Employee *emp in employees) {
    
        [self.context deleteObject:emp];
        
    }
    
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    
}


- (void)addAction2 {
    
    Department *dep = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    dep.createDate = [NSDate date];
    dep.departmentName = @"部门1";
    
    NSError *error = nil;
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
    }
    
}

- (void)readAction2 {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Department"];
    
    NSError *error = nil;
    
    NSArray<Department *> *dmps = [self.context executeFetchRequest:fetchRequest error:&error];
    
    for (Department *dept in dmps) {
        NSLog(@"departmentId=%hd departmentName=%@ createDate=%@ \n employee-%@",dept.departmentId,dept.departmentName,dept.createDate,dept.employee);
    
    
        NSLog(@"%lu",dept.employee.count);
        if (dept.employee.count) {
            Employee *emp = [dept.employee anyObject];
            NSLog(@"Employee Name:%@, age:%hd, Brithday:%@, sectionName:%@", emp.name, emp.age, emp.birthday, emp.sectionName);
        }
        
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
}

- (void)updateAction2 {
    
    NSFetchRequest *fet = [NSFetchRequest fetchRequestWithEntityName:@"Department"];
    
//    fet.predicate = [NSPredicate predicateWithFormat:@"departmentName = %@",@"部门2"];
    
    NSError *error = nil;
   
    NSArray<Department *> *depts = [self.context executeFetchRequest:fet error:&error];
    
    for (Department *dept in depts) {
        dept.departmentName = @"部门2";
    }
    
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    
    if (error) {
        NSLog(@"报错:%@",error);
    }
    
}

- (void)deleteAction2 {
    
}


- (void)pushAlertWithType:(NSString *)clickType {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:clickType preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"%@",alert.textFields[0].text);
        
        if ([clickType isEqualToString:@"增加一个行政分组"]) {
            [self saveNewOrgWithName:alert.textFields[0].text];
        }
        else if ([clickType isEqualToString:@"增加一个成本分组"]) {
            [self saveNewCostWithName:alert.textFields[0].text];
        }
        else if ([clickType isEqualToString:@"增加一个人员"]) {
            [self saveNewEmgWithName:alert.textFields[0].text];
        }
    }]];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"没写空验证，点确定前必须填写名字";
    }];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


- (void)DeptAddAction {
    
    [self pushAlertWithType:@"增加一个行政分组"];
    
}

- (void)CostAddAction {
    
    [self pushAlertWithType:@"增加一个成本分组"];
    
}

- (void)EmpAddAction {
    
    [self pushAlertWithType:@"增加一个人员"];
    
}

- (void)nextPgAction {
    
    DeptAndCostModelViewController *vc = [[DeptAndCostModelViewController alloc] init];
    
    [self showViewController:vc sender:nil];
}

- (void)saveNewOrgWithName:(NSString *)name {
    
    if (!name.length) {
        return;
    }
    
    OrganizationDept *orgDept = [NSEntityDescription insertNewObjectForEntityForName:@"OrganizationDept" inManagedObjectContext:self.context];
    orgDept.name = name;
    
    NSError *error = nil;
    
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
    else {
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@储存成功",name] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:aler animated:YES completion:^{
            [aler dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)saveNewCostWithName:(NSString *)name {
    
    if (!name.length) {
        return;
    }
    
    CostDept *costDept = [NSEntityDescription insertNewObjectForEntityForName:@"CostDept" inManagedObjectContext:self.context];
    costDept.name = name;
    
    NSError *error = nil;
    
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
    else {
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@储存成功",name] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:aler animated:YES completion:^{
            [aler dismissViewControllerAnimated:YES completion:nil];
        }];
    }

}

- (void)saveNewEmgWithName:(NSString *)name {
    
    if (!name.length) {
        return;
    }
    
    SEmployee *newEmp = [NSEntityDescription insertNewObjectForEntityForName:@"SEmployee" inManagedObjectContext:self.context];
    newEmp.name = name;
    
    NSError *error = nil;
    
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
    else {
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@储存成功",name] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:aler animated:YES completion:^{
            [aler dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)saveSomethingUsedInNextPage {
    
    
    
    
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
