//
//  JJISWakeUpViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/19/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISWakeUpViewController.h"
#import "JJISViewController.h"

@interface JJISWakeUpViewController ()

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  prepareForSegue stops playing the podcast and rewinds the audio track. Also, changes the
//  main View Controller's status label to Awake.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDate *now = [NSDate date];
    
    [appDelegate.manager doneSleeping:now];
    
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
