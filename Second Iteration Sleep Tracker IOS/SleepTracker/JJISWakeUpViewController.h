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
@property (weak, nonatomic) IBOutlet UIButton *ExerciseBox;
@property (weak, nonatomic) IBOutlet UIButton *CaffeineBox;
@property (weak, nonatomic) IBOutlet UIButton *StudyingBox;
@property (weak, nonatomic) IBOutlet UIButton *HealthBox;
@property (weak, nonatomic) IBOutlet UIButton *HeartSickBox;
@property (weak, nonatomic) IBOutlet UIButton *otherBox;
@property (strong, nonatomic) IBOutlet UITextField *otherTextField;
- (IBAction)editTextTwo:(id)sender;

- (IBAction)RatingBar:(id)sender;
- (IBAction)ExerciseOption:(id)sender;
- (IBAction)CaffeineOption:(id)sender;
- (IBAction)StudyingOption:(id)sender;
- (IBAction)HealthOption:(id)sender;
- (IBAction)HeartSickOption:(id)sender;
- (IBAction)otherOption:(id)sender;
- (IBAction)otherBeginEdit:(id)sender;
- (IBAction)otherEndEdit:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)iamawake:(id)sender;

@end
