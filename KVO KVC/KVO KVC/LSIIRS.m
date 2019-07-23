//
//  LSIIRS.m
//  KVO KVC
//
//  Created by Paul Solt on 7/23/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIIRS.h"
#import "LSIEmployee.h"

void *KVOContext = &KVOContext; // 233493938383939 ... 0xADF03834A

@interface LSIIRS ()

@property (nonatomic, strong) NSMutableArray *monitoredEmployees;

@end

@implementation LSIIRS

- (instancetype)init
{
    self = [super init];
    if (self) {
        _monitoredEmployees = [@[] mutableCopy];
    }
    return self;
}


- (void)startMonitoringEmployee:(LSIEmployee *)employee {
    
    // add the observer
    [employee addObserver:self forKeyPath:@"salary" options:0 context:KVOContext];
    [employee addObserver:self forKeyPath:@"jobTitle" options:NSKeyValueObservingOptionInitial context:KVOContext];
    
    
    [self.monitoredEmployees addObject:employee];
    // NSKeyValueObservingOptionInitial = fire with the first value
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == KVOContext) {    // Only give me notifications for what I have requested
        
        
//        if ([keyPath isEqualToString:@"salary"]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(salary))]) {
            NSLog(@"IRS sees a pay increase for %@'s salary to: %@", [object name], [object valueForKeyPath:keyPath]);
        
        } else if([keyPath isEqualToString:@"jobTitle"]) {
            NSLog(@"IRS: %@ changed their job to: %@", [object name], [object valueForKeyPath:keyPath]);
        }
        
        
        
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



- (void)dealloc
{
    // cleanup
    NSLog(@"Cleanup the IRS it's shutdown!");
    // remove the observers
    for (LSIEmployee *employee in self.monitoredEmployees) {
        [employee removeObserver:self forKeyPath:@"salary"];
        [employee removeObserver:self forKeyPath:@"jobTitle"];
    }
}

@end
