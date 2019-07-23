//
//  LSIDepartment.h
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSIEmployee;

@interface LSIDepartment : NSObject

- (void)addEmployee:(LSIEmployee *)employee;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) LSIEmployee *manager;
@property (nonatomic, copy, readonly) NSArray<LSIEmployee *> *employees;

@end

NS_ASSUME_NONNULL_END
