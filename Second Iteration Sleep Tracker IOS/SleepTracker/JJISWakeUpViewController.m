//
//  JJISWakeUpViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/19/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISWakeUpViewController.h"
#import "JJISViewController.h"
#import "JJISSleepExplanation.h"

@interface JJISWakeUpViewController ()
@property BOOL ExerciseOption;
@property BOOL CaffeineOption;
@property BOOL StudyingOption;
@property BOOL HealthOption;
@property BOOL HeartSickOption;
@property BOOL otherOption;
@property (nonatomic, strong) NSString* textfieldtext;
@end


@implementation JJISWakeUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* twinkle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    twinkle.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Back1.png"], [UIImage imageNamed:@"Back2.png"], [UIImage imageNamed:@"Back3.png"], [UIImage imageNamed:@"Back4.png"], [UIImage imageNamed:@"Back5.png"], [UIImage imageNamed:@"Back6.png"], nil ];
    twinkle.animationDuration = 2;
    twinkle.animationRepeatCount = 0;
    [twinkle startAnimating];
    [self.view addSubview:twinkle];
    [self.view sendSubviewToBack:twinkle];
    
  
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// RatingBar allows the user to see what value of sleep quality is selected using the slider.
- (IBAction)editTextTwo:(id)sender {
}

- (IBAction)RatingBar:(id)sender {
    UISlider *slider = (UISlider*) sender;
    self.ratingValue.text = [NSString stringWithFormat:@"%d", (int)[slider value]];
}

// ExerciseOption allows the user to select and deselect a checkbox saying that they exercise before sleep.
- (IBAction)ExerciseOption:(id)sender {
    if(self.ExerciseOption){
        self.ExerciseOption = false;
        [self.ExerciseBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    else{
        self.ExerciseOption = true;
        [self.ExerciseBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }
}

// CaffeineOption allows the user to select and deselect a checkbox saying that they had caffeine before sleep.
- (IBAction)CaffeineOption:(id)sender {
    if(self.CaffeineOption){
        self.CaffeineOption = false;
        [self.CaffeineBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    else{
        self.CaffeineOption = true;
        [self.CaffeineBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }
}

// StudyingOption allows the user to select and deselect a checkbox saying that they studied before sleep.
- (IBAction)StudyingOption:(id)sender {
    if(self.StudyingOption){
        self.StudyingOption = false;
        [self.StudyingBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    else{
        self.StudyingOption = true;
        [self.StudyingBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }
}

// HealthOption allows the user to select and deselect a checkbox saying that they were sick.
- (IBAction)HealthOption:(id)sender {
    if(self.HealthOption){
        self.HealthOption = false;
        [self.HealthBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    else{
        self.HealthOption = true;
        [self.HealthBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }
}

// HeartSickOption allows the user to select and deselect a checkbox saying that they experienced heart ache before sleep.
- (IBAction)HeartSickOption:(id)sender {
    if(self.HeartSickOption){
        self.HeartSickOption = false;
        [self.HeartSickBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    else{
        self.HeartSickOption = true;
        [self.HeartSickBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }
}

// OtherOption allows the user to select and deselect a checkbox saying that they exercise before sleep.
- (IBAction)otherOption:(id)sender {
    if(self.otherOption){
        self.otherOption = false;
        [self.otherBox setImage:[UIImage imageNamed:@"EmptyBox.png"] forState:UIControlStateNormal];
    }
    /*else{
        self.otherOption = true;
        [self.otherBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];    }*/
}

// otherBeginEdit moves the screen up so the other explanation text field is visible when the keyboard appears.
- (IBAction)otherBeginEdit:(id)sender {
    
    self.otherTextField.text = @"";
    /*NSTimeInterval animationDuration = 0.300000011920929;
    CGRect frame = self.view.frame;
    frame.origin.y -= 0;
    frame.size.height += 0;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];*/
    
}

// otherEndEdit moves the screen back to normal when the user is done typing an other explanation.
- (IBAction)otherEndEdit:(id)sender {
 /*   NSTimeInterval animationDuration = 0.300000011920929;
    CGRect frame = self.view.frame;
    frame.origin.y += 0;
    frame.size.height -= 0;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];*/
    self.otherOption = true;
    [self.otherBox setImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateNormal];
    self.textfieldtext = [self.otherTextField text];
    
}

// dismissKeyoard removes the keyboard when the user is done typing.
- (IBAction)dismissKeyboard:(id)sender {
    [self.otherTextField becomeFirstResponder];
    [self.otherTextField resignFirstResponder];
}

- (IBAction)iamawake:(id)sender {
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDate *now = [NSDate date];
    
    
    JJISSleepExplanation* sleepExp = [[JJISSleepExplanation alloc] init];
    [sleepExp setExplanations:self.ExerciseOption :self.CaffeineOption :self.StudyingOption : self.HealthOption : self.HeartSickOption : self.otherOption : self.ratingValue.text :self.textfieldtext];
    [appDelegate.manager doneSleeping:now:sleepExp];
}

//  prepareForSegue stops playing the podcast and rewinds the audio track. Also, changes the
//  main View Controller's status label to Awake.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    JJISSleepExplanation* sleepExp = [[JJISSleepExplanation alloc] init];
    [sleepExp setExplanations:self.ExerciseOption :self.CaffeineOption :self.StudyingOption : self.HealthOption : self.HeartSickOption : self.otherOption : self.ratingValue.text :self.textfieldtext];
  //  [appDelegate.manager doneSleeping:now:sleepExp];
    
    if (appDelegate.audioPlayer.isPlaying) {
        appDelegate.audioPlayer.currentTime = 0;
        [appDelegate.audioPlayer stop];
    }
    
    NSString *status = @"Awake";
    
    JJISViewController *destination = segue.destinationViewController;
    if ([destination view]) {
        destination.statusLabel.text = status;
    }
    
}
@end
