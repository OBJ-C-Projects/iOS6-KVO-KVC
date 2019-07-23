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
    [employee addObserver:self forKeyPath:@"salary" options:0 context:NULL]; //KVOContext];
    
    [self.monitoredEmployees addObject:employee];
    // NSKeyValueObservingOptionInitial = fire with the first value
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == KVOContext) {
        
        NSLog(@"IRS sees a pay increase for %@'s salary to: %@", object, [object valueForKeyPath:keyPath]);
        
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



- (void)dealloc
{
    // cleanup
    
    // remove the observers
}

@end
