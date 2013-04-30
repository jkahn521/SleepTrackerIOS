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
@property BOOL areWeNapping;

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

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.playPodcast = true;
    self.areWeNapping = false;
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


// SleepTime if the user selects to listen to the podcast, the podcast begins playing else it does not.
// The time of this sleep start is logged.
- (IBAction)SleepTime:(id)sender {
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (self.playPodcast == true) {
        [appDelegate.audioPlayer play];
    }
    
    if (self.playPodcast == false) {
        appDelegate.audioPlayer.currentTime = 0;
        [appDelegate.audioPlayer pause];
        
    }
    
    NSDate *now = [NSDate date];
    [appDelegate.manager startSleeping:now:self.areWeNapping];
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

// isThisANap allows the user to toggle between the sleep and nap options.
- (IBAction)isThisANap:(id)sender {
    if(self.areWeNapping) {
        self.areWeNapping = false;
    }
    else {
        self.areWeNapping = true;
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

// prepareForSegue makes the status on the home screen change from Awake to Sleeping.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   /* if ([segue.identifier isEqualToString:@"Sleeping"]) {
        NSString *status = @"Sleeping";
        JJISViewController *destination = segue.destinationViewController;
        if ([destination view]) {
            destination.statusLabel.text = status;
        }
    }*/
}

@end
