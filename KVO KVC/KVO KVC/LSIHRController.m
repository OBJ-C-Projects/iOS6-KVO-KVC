//
//  LSIHRDepartment.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIHRController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"

@interface LSIHRController ()

@property (nonatomic) NSMutableArray <LSIDepartment *> *internalDepartments;
@end


@implementation LSIHRController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalDepartments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addDepartment:(LSIDepartment *)department {
    [self.internalDepartments addObject:department];
}

- (NSArray<LSIDepartment *> *)departments {
    return [self.internalDepartments copy];
}



- (NSString *)description {
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendString:@"Departments:\n"];
    for (LSIDepartment *department in self.departments) {
        [output appendFormat:@"%@", department];
    }
    return output;
}


- (NSArray *)allEmployees {
//    NSMutableArray *employees = [[NSMutableArray alloc] init];
//    for (LSIDepartment *department in self.departments) {
//        [employees addObjectsFromArray:department.employees];
//    }
//    return employees;
    
//    NSString *departmentsKeyPath = NSStringFromSelector(@selector(departments));
//    NSLog(@"departmentsKeyPath: %@", departmentsKeyPath);
    return [self valueForKeyPath:@"departments.@unionOfArrays.employees"];
}


//- (NSInteger)highestSalary {
//
//    // loop over all the employees, find the highest, then return their salary
//    LSIEmployee *highestPaid = nil;
//
//    for (LSIEmployee *employee in self.allEmployees) {
//        if (employee.salary > highestPaid.salary) {
//            highestPaid = employee;
//        }
//    }
//
//    return highestPaid.salary;
//}

- (NSInteger)highestSalary {
//    return [[self.allEmployees valueForKeyPath:@"@max.salary"] integerValue];
    return [[self.allEmployees valueForKeyPath:@"@avg.salary"] integerValue];

}


@end
