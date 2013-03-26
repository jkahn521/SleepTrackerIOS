//
//  JJISGoToSleepViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  Controller for the window used when going to sleep. Allows user to choose to listen to the podcast
//  and to begin sleeping.

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface JJISGoToSleepViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *GoHome;

- (IBAction)SleepTime:(id)sender;
- (IBAction)SelectPodcastPlay:(id)sender;
- (IBAction)isThisANap:(id)sender;
- (IBAction)Play_Pause:(id)sender;

@end
