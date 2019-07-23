//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"
#import "LSIIRS.h"

@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
    NSLog(@"%@", self.hrController);
    
    NSLog(@"All Employees: %@", controller.allEmployees);
    
    
//     self.hrController.departments
    NSLog(@"%@" , [self.hrController valueForKeyPath:@"departments"]);
    
    NSLog(@"%@" , [self.hrController valueForKeyPath:@"departments.employees"]);

    NSLog(@"%@" , [self.hrController valueForKeyPath:@"departments.@unionOfArrays.employees"]);
    
    // Remove any dupilicates (Set)
    NSLog(@"%@" , [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"]);

    
    LSIIRS *irs = [[LSIIRS alloc] init];
    
    [irs startMonitoringEmployee:e3];
    
}

- (IBAction)printHighestSalaryPressed:(id)sender {

    NSLog(@"Highest Salary: %li", self.hrController.highestSalary);

}

- (IBAction)giveJoeARaisePressed:(id)sender {
    
    // Find Joe
    // Give him a raise (passing by reference)
    NSArray *allEmployees = self.hrController.allEmployees; //
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"Joe"];
//    NSArray *allJoes = [allEmployees filteredArrayUsingPredicate:predicate];
    LSIEmployee *joe = [allEmployees filteredArrayUsingPredicate:predicate].firstObject;
//    joe.salary
    
//    [joe setValue:@(joe.salary + 25000) forKey:@"salary"];
    joe.salary = joe.salary + 25000;
    NSLog(@"Joe: %@", joe);
}

@end
