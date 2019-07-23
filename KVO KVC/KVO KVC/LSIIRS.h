//
//  LSIIRS.h
//  KVO KVC
//
//  Created by Paul Solt on 7/23/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIEmployee;

NS_ASSUME_NONNULL_BEGIN

@interface LSIIRS : NSObject

- (void)startMonitoringEmployee:(LSIEmployee *)employee;

@end

NS_ASSUME_NONNULL_END
