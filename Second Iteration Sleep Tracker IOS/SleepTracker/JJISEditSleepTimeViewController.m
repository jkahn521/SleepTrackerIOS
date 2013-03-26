//
//  JJISEditSleepTimeViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 3/10/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISEditSleepTimeViewController.h"
#import "JJISAppDelegate.h"
#import "JJISSleepDetailViewController.h"

@interface JJISEditSleepTimeViewController ()
@property BOOL sleepWakeSwitch;



@end

@implementation JJISEditSleepTimeViewController

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
	// Do any additional setup after loading the view.
    self.sleepWakeSwitch = true;
    UIImageView* twinkle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    twinkle.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Back1.png"], [UIImage imageNamed:@"Back2.png"], [UIImage imageNamed:@"Back3.png"], [UIImage imageNamed:@"Back4.png"], [UIImage imageNamed:@"Back5.png"], [UIImage imageNamed:@"Back6.png"], nil ];
    twinkle.animationDuration = 2;
    twinkle.animationRepeatCount = 0;
    [twinkle startAnimating];
    [self.view addSubview:twinkle];
    [self.view sendSubviewToBack:twinkle];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SelectSleepWake allows the user to toggle between the sleep and wake part of the control button to edit the desired time.
- (IBAction)SelectSleepWake:(id)sender {
    if (self.sleepWakeSwitch) {
        self.start = self.datePicker.date;
        self.datePicker.date = self.end;
        [self.datePicker setMinimumDate:self.start];
        [self.datePicker setMaximumDate:nil];
        self.sleepWakeSwitch = false;
    }
    else {
        self.end = self.datePicker.date;
        self.datePicker.date = self.start;
        [self.datePicker setMaximumDate:self.end];
        [self.datePicker setMinimumDate:nil];
        self.sleepWakeSwitch = true;

    }
}

// UpdateSleepTime sets the corresponding SleepInfo data to the new sleep and wake times.
- (IBAction)UpdateSleepTime:(id)sender {
    NSDate *pickerDate = [self.datePicker date];
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (self.sleepWakeSwitch) {
        [appDelegate.manager setSleepTime:pickerDate:self.end:self.row:self.nap];
    }
    else {
        [appDelegate.manager setSleepTime:self.start:pickerDate:self.row:self.nap];
    }
}

// prepareForSegue sets the labels in the DetailViewController equal to the newly edited values.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UnwindUpdate"]) {
        JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSArray *infoStrings = [appDelegate.manager getInfo:self.row];
        JJISSleepDetailViewController *destination = segue.destinationViewController;
        if ([destination view]) {
            destination.dateStartLabel.text = infoStrings[0];
            destination.startLabel.text = infoStrings[1];
            destination.endLabel.text = infoStrings[2];
            destination.durationLabel.text = infoStrings[3];
            destination.dateEndLabel.text = infoStrings[4];
            destination.TypeSleep.text = infoStrings[5];
        }
    }
}


@end
