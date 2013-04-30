//
//  JJISSleepDetailViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/23/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController for looking at a specific sleep entries information. Displays the start date and time,
//  the end time, and the sleep duration in minutes.

#import <UIKit/UIKit.h>

@interface JJISSleepDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *TypeSleep;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateEndLabel;
@property int row;
@property BOOL areWeNapping;

- (IBAction)EditSleepTime:(id)sender;

@end
