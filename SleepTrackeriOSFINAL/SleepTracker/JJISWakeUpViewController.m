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
@property BOOL ScreenTimeOption;
@property BOOL SugarOption;
@property BOOL AlcoholOption;
@property BOOL NicotineOption;
@property (strong, nonatomic) NSNumber* rating;

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
    self.rating = [NSNumber numberWithFloat:3.0f];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// RatingBar sets the SleepInfo's rating value to the value of the slider and sets the text within
// the WakeUpViewController
- (IBAction)RatingBar:(id)sender {
    UISlider *slider = (UISlider*) sender;
    self.ratingValue.text = [NSString stringWithFormat:@"%d", (int)[slider value]];
    self.rating = [NSNumber numberWithInt:[slider value]];
    //NSLog(@"float value = %@", self.rating);
}

// ExerciseOption allows the user to select and deselect a checkbox saying that they exercise before sleep.
- (IBAction)ExerciseOption:(id)sender {
    if(self.ExerciseOption){
        self.ExerciseOption = false;
        [self.ExerciseBox setImage:[UIImage imageNamed:@"exercise_off.png"] forState:UIControlStateNormal];
    }
    else{
        self.ExerciseOption = true;
        [self.ExerciseBox setImage:[UIImage imageNamed:@"exercise_on.png"] forState:UIControlStateNormal];    }
}

// CaffeineOption allows the user to select and deselect a checkbox saying that they had caffeine before sleep.
- (IBAction)CaffeineOption:(id)sender {
    if(self.CaffeineOption){
        self.CaffeineOption = false;
        [self.CaffeineBox setImage:[UIImage imageNamed:@"coffee_off.png"] forState:UIControlStateNormal];
    }
    else{
        self.CaffeineOption = true;
        [self.CaffeineBox setImage:[UIImage imageNamed:@"coffee_on.png"] forState:UIControlStateNormal];    }
}

// NicotineOption allows the user to select and deselect a checkbox saying that they used nicotine before sleep.
- (IBAction)NicotineOption:(id)sender {
    if(self.NicotineOption) {
        self.NicotineOption = false;
        [self.NicotineBox setImage:[UIImage imageNamed:@"nicotine_off.png"] forState:UIControlStateNormal];
    }
    else {
        self.NicotineOption = true;
        [self.NicotineBox setImage:[UIImage imageNamed:@"nicotine_on.png"] forState:UIControlStateNormal];
    }
}

// ScreenTimeOption allows the user to select and deselect a checkbox saying that they looked at a screen before sleep.
- (IBAction)ScreenTimeOption:(id)sender {
    if(self.ScreenTimeOption){
        self.ScreenTimeOption = false;
        [self.ScreenTimeBox setImage:[UIImage imageNamed:@"screen_off.png"] forState:UIControlStateNormal];
    }
    else{
        self.ScreenTimeOption = true;
        [self.ScreenTimeBox setImage:[UIImage imageNamed:@"screen_on.png"] forState:UIControlStateNormal];    }
}

// SugarOption allows the user to select and deselect a checkbox saying that they had sugar before sleep.
- (IBAction)SugarOption:(id)sender {
    if(self.SugarOption){
        self.SugarOption = false;
        [self.SugarBox setImage:[UIImage imageNamed:@"sugar_off.png"] forState:UIControlStateNormal];
    }
    else{
        self.SugarOption = true;
        [self.SugarBox setImage:[UIImage imageNamed:@"sugar_on.png"] forState:UIControlStateNormal];    }
}


// AlcoholOption allows the user to select and deselect a checkbox saying that they consumed alcohol before sleep.
- (IBAction)AlcoholOption:(id)sender {
    if(self.AlcoholOption){
        self.AlcoholOption = false;
        [self.AlcoholBox setImage:[UIImage imageNamed:@"beer_off.png"] forState:UIControlStateNormal];
    }
    else{
        self.AlcoholOption = true;
        [self.AlcoholBox setImage:[UIImage imageNamed:@"beer_on.png"] forState:UIControlStateNormal];    }
}

// WakeUp is called when the user finishes sleeping. A SleepInfo describing the sleep is added to the program.
- (IBAction)WakeUp:(id)sender {
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDate *now = [NSDate date];
    JJISSleepExplanation* sleepExp = [[JJISSleepExplanation alloc] init];
    [sleepExp setExplanations:self.CaffeineOption :self.AlcoholOption :self.NicotineOption :self.SugarOption :self.ScreenTimeOption :self.ExerciseOption :self.rating];
    [appDelegate.manager doneSleeping:now:sleepExp];
}

//  prepareForSegue stops playing the podcast and rewinds the audio track. Also, changes the
//  main View Controller's status label to Awake.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    JJISSleepExplanation* sleepExp = [[JJISSleepExplanation alloc] init];
    [sleepExp setExplanations:self.CaffeineOption :self.AlcoholOption :self.NicotineOption :self.SugarOption :self.ScreenTimeOption :self.ExerciseOption :self.rating];
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
