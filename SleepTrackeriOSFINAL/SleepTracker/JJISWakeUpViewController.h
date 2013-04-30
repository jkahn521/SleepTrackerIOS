//
//  JJISWakeUpViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/19/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController for the Wake Up screen. Allows user to say that they're awake and stop the podcast.

#import <UIKit/UIKit.h>
#import "JJISAppDelegate.h"

@interface JJISWakeUpViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ratingValue;
@property (weak, nonatomic) IBOutlet UIButton *NicotineBox;
@property (weak, nonatomic) IBOutlet UIButton *ExerciseBox;
@property (weak, nonatomic) IBOutlet UIButton *CaffeineBox;
@property (weak, nonatomic) IBOutlet UIButton *ScreenTimeBox;
@property (weak, nonatomic) IBOutlet UIButton *SugarBox;
@property (weak, nonatomic) IBOutlet UIButton *AlcoholBox;

- (IBAction)RatingBar:(id)sender;
- (IBAction)ExerciseOption:(id)sender;
- (IBAction)CaffeineOption:(id)sender;
- (IBAction)NicotineOption:(id)sender;
- (IBAction)ScreenTimeOption:(id)sender;
- (IBAction)SugarOption:(id)sender;
- (IBAction)AlcoholOption:(id)sender;
- (IBAction)WakeUp:(id)sender;

@end
