//
//  LSIStopWatch.m
//  StopWatchDemo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIStopWatch.h"


@interface LSIStopWatch ()

@property (nonatomic, readwrite, getter=isRunning) BOOL running;
@property (nonatomic, readwrite) NSTimeInterval elapsedTime;

@property (nonatomic) NSDate *startDate; // Used to know at what time the timer started.
@property (nonatomic) NSTimer *timer;

@property (nonatomic) NSTimeInterval previousElapsedTime;


@end

@implementation LSIStopWatch



- (void)start
{
    self.startDate = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                  target:self
                                                selector:@selector(timerDidFire:)
                                                userInfo:nil
                                                 repeats:YES];
    self.running = YES;
    
}

- (void)stop
{
    self.previousElapsedTime = self.elapsedTime;
    self.timer = nil;
    self.startDate = nil;
    self.running = NO;
}


- (void)reset {
    [self stop];
    self.elapsedTime = 0;
    self.previousElapsedTime = 0;
}

- (void)timerDidFire:(NSTimer *)timer;
{
    self.elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startDate] + self.previousElapsedTime;
}


- (void)setTimer:(NSTimer *)timer
{
    if (timer != _timer) {
        [_timer invalidate]; // Make sure the old timer isn't running as well
        _timer = timer;
    }
}


@end
