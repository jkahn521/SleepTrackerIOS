//
//  JJISGoToSleepViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISGoToSleepViewController.h"
#import "JJISAppDelegate.h"
#import "JJISViewController.h"

@interface JJISGoToSleepViewController ()
@property BOOL playPodcast;

@end

@implementation JJISGoToSleepViewController

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
    self.playPodcast = true;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SleepTime if the user selects to listen to the podcast, the podcast begins playing else it does not.
// The time of this sleep start is logged.
- (IBAction)SleepTime:(id)sender {
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (self.playPodcast == true) {
        [appDelegate.audioPlayer play];
    }
    NSDate *now = [NSDate date];
    [appDelegate.manager startSleeping:now];
}

// SelectPodcastPlay is called by the switch in order to toggle between listening and not listening
// to the podcast.
- (IBAction)SelectPodcastPlay:(id)sender {
    if (self.playPodcast == true) {
        self.playPodcast = false;
    }
    else {
        self.playPodcast = true;
    }
}

// play/pause button functionality. checks if the podcast is already playing and plays / pauses it accordingly
- (IBAction)Play_Pause:(id)sender {
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.audioPlayer.isPlaying) {
       // NSLog(@"pause!\n");
        [appDelegate.audioPlayer pause];
    }
    else {
      //  NSLog(@"play!\n");
        [appDelegate.audioPlayer play];
    }
    

}

// segueeee
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *status = @"Sleeping";
    
    
    JJISViewController *destination = segue.destinationViewController;
    if ([destination view]) {
        destination.statusLabel.text = status;
    }
}

@end
