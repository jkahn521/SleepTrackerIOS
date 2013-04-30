//
//  JJISEditSleepTimeViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 3/10/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController where the user edits existing sleep data.

#import <UIKit/UIKit.h>

@interface JJISEditSleepTimeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, atomic) NSDate*start;
@property (strong, atomic) NSDate*end;
@property int row;
@property BOOL nap;

- (IBAction)SelectSleepWake:(id)sender;
- (IBAction)UpdateSleepTime:(id)sender;



@end
