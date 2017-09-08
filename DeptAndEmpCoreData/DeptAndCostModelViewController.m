//
//  DeptAndCostModelViewController.m
//  DeptAndEmpCoreData
//
//  Created by 首汽租赁 on 2017/9/6.
//  Copyright © 2017年 杜俊楠. All rights reserved.
//

#import "DeptAndCostModelViewController.h"
#import "OrganizationDept+CoreDataClass.h"
#import "CostDept+CoreDataClass.h"
#import "SEmployee+CoreDataClass.h"
#import <CoreData/CoreData.h>

@interface DeptAndCostModelViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *backPgBtn;

@property (nonatomic,strong) UITableView *orgDeptTableView;

@property (nonatomic,strong) UITableView *costDeptTableView;

@property (nonatomic,strong) UITableView *employeeListTableView;

@property (nonatomic,strong) NSManagedObjectContext *context;




@property (nonatomic,strong) NSMutableArray *orgDeptOriginalDataSource;
@property (nonatomic,strong) NSMutableArray *orgDeptDataSource;

@property (nonatomic,strong) NSMutableArray *costDeptOriginalDataSource;
@property (nonatomic,strong) NSMutableArray *costDeptDataSource;

@property (nonatomic,strong) NSMutableArray *employeeListOriginalDataSource;
@property (nonatomic,strong) NSMutableArray *employeeListDataSource;


@end

@implementation DeptAndCostModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createUI];
    
    [self createData];
    
}

- (void)createUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.orgDeptTableView];
    [self.view addSubview:self.costDeptTableView];
    [self.view addSubview:self.employeeListTableView];
    
    [self.view addSubview:self.backPgBtn];
    
}

- (void)createData {
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"DeptAndCostModel" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSPersistentStoreCoordinator *persistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingFormat:@"/%@.sqlite",@"DeptAndCost"];
    [persistent addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    
    self.context.persistentStoreCoordinator = persistent;
    
    NSError *error = nil;
    
    NSFetchRequest *orgRequset = [NSFetchRequest fetchRequestWithEntityName:@"OrganizationDept"];
    self.orgDeptOriginalDataSource = [[NSMutableArray alloc] initWithArray:[self.context executeFetchRequest:orgRequset error:&error]];
    self.orgDeptDataSource = [[NSMutableArray alloc] init];
    [self.orgDeptOriginalDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OrganizationDept *org = obj;
//        NSLog(@"%lu----<%@>\n<%@>\n<%@>",(unsigned long)idx,org.name,org.costDept,org.semployee);
        SEmployee *emp = org.semployee;
        NSArray *costArr = [[NSArray alloc] initWithArray:[org.costDept allObjects]];
        NSMutableString *costDeptName = [[NSMutableString alloc] init];
        for (CostDept *cD in costArr) {
            if (costDeptName.length) {
                [costDeptName appendFormat:@"/%@",cD.name];
            }
            else {
                [costDeptName appendFormat:@"%@",cD.name];
            }
        }
        NSDictionary *dict = @{@"name":org.name,@"costDept":costArr.count?costDeptName:@"未添加成本分组",@"semployee":emp?emp.name:@"未添加任何员工"};
        [self.orgDeptDataSource addObject:dict];
        
    }];
    if (error) {
        NSLog(@"%@报错%@",@"OrganizationDept",error);
    }
    
    
    
    NSFetchRequest *costRequset = [NSFetchRequest fetchRequestWithEntityName:@"CostDept"];
    self.costDeptOriginalDataSource = [[NSMutableArray alloc] initWithArray:[self.context executeFetchRequest:costRequset error:&error]];
    self.costDeptDataSource = [[NSMutableArray alloc] init];
    [self.costDeptOriginalDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CostDept *costDept = obj;
//        NSLog(@"%lu----<%@>\n<%@>\n<%@>",(unsigned long)idx,costDept.name,costDept.organizationDept,costDept.semployee);
        SEmployee *emp = costDept.semployee;
        NSArray *orgArr = [[NSArray alloc] initWithArray:[costDept.organizationDept allObjects]];
        NSMutableString *orgDeptName = [[NSMutableString alloc] init];
        for (OrganizationDept *oD in orgArr) {
            if (orgDeptName.length) {
                [orgDeptName appendFormat:@"/%@",oD.name];
            }
            else {
                [orgDeptName appendFormat:@"%@",oD.name];
            }
        }
        NSDictionary *dict = @{@"name":costDept.name,@"orgDept":orgArr.count?orgDeptName:@"未添加行政分组",@"semployee":emp?emp.name:@"为添加任何员工"};
        [self.costDeptDataSource addObject:dict];
        
    }];
    if (error) {
        NSLog(@"%@报错%@",@"CostDept",error);
    }

    
    
    NSFetchRequest *empRequset = [NSFetchRequest fetchRequestWithEntityName:@"SEmployee"];
    self.employeeListOriginalDataSource = [[NSMutableArray alloc] initWithArray:[self.context executeFetchRequest:empRequset error:&error]];
    self.employeeListDataSource = [[NSMutableArray alloc] init];
    [self.employeeListOriginalDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEmployee *semploy = obj;
//        NSLog(@"%lu----<%@>\n<%@>\n<%@>",(unsigned long)idx,semploy.name,semploy.costDept,semploy.organizationDept);
        OrganizationDept *orgDept = semploy.organizationDept;
        CostDept *costDept = semploy.costDept;
        NSDictionary *dict = @{@"name":semploy.name,@"costDept":costDept?costDept.name:@"未添加成本分组",@"orgDept":orgDept?orgDept.name:@"未添加行政分组"};
        [self.employeeListDataSource addObject:dict];
    }];
    if (error) {
        NSLog(@"%@报错%@",@"SEmployee",error);
    }

    [self.orgDeptTableView reloadData];
    [self.costDeptTableView reloadData];
    [self.employeeListTableView reloadData];
}





- (UIButton *)backPgBtn {
    
    if (!_backPgBtn) {
        
        _backPgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backPgBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-100, 50, 50);
        _backPgBtn.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [_backPgBtn setTitle:@"backPG" forState:UIControlStateNormal];
        [_backPgBtn addTarget:self action:@selector(backPgAction) forControlEvents:UIControlEventTouchDown];
    }
    return _backPgBtn;
}

- (UITableView *)orgDeptTableView {
    
    if (!_orgDeptTableView) {
        
        _orgDeptTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/3) style:UITableViewStylePlain];
        _orgDeptTableView.delegate = self;
        _orgDeptTableView.dataSource = self;
        _orgDeptTableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _orgDeptTableView;
}

- (UITableView *)costDeptTableView {
    
    if (!_costDeptTableView) {
        
        _costDeptTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/3) style:UITableViewStylePlain];
        _costDeptTableView.delegate = self;
        _costDeptTableView.dataSource = self;
        _costDeptTableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _costDeptTableView;
}

- (UITableView *)employeeListTableView {
    
    if (!_employeeListTableView) {
        
        _employeeListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*2/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/3) style:UITableViewStylePlain];
        _employeeListTableView.delegate = self;
        _employeeListTableView.dataSource = self;
        _employeeListTableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _employeeListTableView;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _orgDeptTableView) {
        return _orgDeptDataSource.count;
    }
    else if (tableView == _costDeptTableView) {
        return _costDeptDataSource.count;
    }
    else if (tableView == _employeeListTableView) {
        return _employeeListDataSource.count;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _orgDeptTableView) {
        static NSString *reuseId = @"orgDeptTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
            cell.backgroundColor = [UIColor colorWithRed:135/255.f green:206/255.f blue:250/255.f alpha:0.5];
        }
        
        if (_orgDeptDataSource.count) {
            NSDictionary *dict = _orgDeptDataSource[indexPath.row];
            cell.textLabel.text = dict[@"name"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",dict[@"costDept"],dict[@"semployee"]];
        }
        
        return cell;
    }
    else if (tableView == _costDeptTableView) {
        static NSString *reuseId = @"costDeptTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
            cell.backgroundColor = [UIColor colorWithRed:255/255.f green:165/255.f blue:0/255.f alpha:0.5];
        }
        
        if (_costDeptDataSource.count) {
            NSDictionary *dict = _costDeptDataSource[indexPath.row];
            cell.textLabel.text = dict[@"name"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",dict[@"orgDept"],dict[@"semployee"]];
        }
        
        return cell;
    }
    else if (tableView == _employeeListTableView) {
        static NSString *reuseId = @"employeeListTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
            cell.backgroundColor = [UIColor colorWithRed:240/255.f green:255/255.f blue:240/255.f alpha:0.5];
        }
        
        if (_employeeListDataSource.count) {
            NSDictionary *dict = _employeeListDataSource[indexPath.row];
            cell.textLabel.text = dict[@"name"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",dict[@"orgDept"],dict[@"costDept"]];
        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _employeeListTableView) {
        
        //[self choiceADeptWithIndex:indexPath.row];
    
    }
    
}

//这个方法的本意是选一个员工添加给其添加行政分组和成本分组，但没有做完，不过如果你是来看多表关联的，并不影响你。
- (void)choiceADeptWithIndex:(NSInteger )index {
    
    SEmployee *semp = self.employeeListOriginalDataSource[index];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择一个行政分组" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < self.orgDeptDataSource.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:self.orgDeptDataSource[i][@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            OrganizationDept *orgDept = self.orgDeptOriginalDataSource[i];
            semp.organizationDept = orgDept;
            if (self.context.hasChanges) {
                [self.context save:nil];
            }
            
            [self.employeeListTableView reloadData];
        }];
        [alert addAction:action];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
    
    
}







- (void)backPgAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
