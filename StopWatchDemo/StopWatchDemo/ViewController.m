//
//  ViewController.m
//  StopWatchDemo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIStopWatch.h"


// An address to nothing in particular with the value being the address itself.
void *KVOContext = &KVOContext; // 23109840129384109283


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic) LSIStopWatch *stopwatch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stopwatch = [[LSIStopWatch alloc] init];

    self.timeLabel.font = [UIFont monospacedDigitSystemFontOfSize: self.timeLabel.font.pointSize weight: UIFontWeightRegular];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.stopwatch reset];
}

- (IBAction)startStopButtonPressed:(id)sender {
    if (self.stopwatch.isRunning) {
        [self.stopwatch stop];
    } else {
        [self.stopwatch start];
    }
}

- (void)updateViews
{
    if (self.stopwatch.isRunning) {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    self.resetButton.enabled = self.stopwatch.elapsedTime > 0;
    
    self.timeLabel.text = [self stringFromTimeInterval:self.stopwatch.elapsedTime];
//    self.timeLabel.text = [self stringFromTime:self.stopwatch.elapsedTime];
}


- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger timeIntervalAsInt = (NSInteger)interval;
    NSInteger tenths = (NSInteger)((interval - floor(interval)) * 100);
    NSInteger seconds = timeIntervalAsInt % 60;
    NSInteger minutes = (timeIntervalAsInt / 60) % 60;
    NSInteger hours = (timeIntervalAsInt / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%02ld", (long)hours, (long)minutes, (long)seconds, (long)tenths];
}

// This won't work for milliseconds
- (NSString *)stringFromTime:(NSTimeInterval)time {
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
//    formatter.includesApproximationPhrase = YES;
//    formatter.includesTimeRemainingPhrase = YES;
    formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
    formatter.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond | NSCalendarUnitHour;
    formatter.allowsFractionalUnits = YES;

    return [formatter stringFromTimeInterval:time];
}


- (void)setStopwatch:(LSIStopWatch *)stopwatch
{
    
    if (stopwatch != _stopwatch) {
        
        [_stopwatch removeObserver:self forKeyPath:@"running" context:KVOContext];
        [_stopwatch removeObserver:self forKeyPath:@"elapsedTime" context:KVOContext];

        // willSet

        _stopwatch = stopwatch;
        
        // didSet
        
        [_stopwatch addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_stopwatch addObserver:self forKeyPath:@"elapsedTime" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == KVOContext) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // This will remove our observers
    self.stopwatch = nil;
}

@end
