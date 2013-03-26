//
//  JJISAppDelegate.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  AppDelegate contains the SleepInfoManager and the audio player for podcast playing.

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JJISSleepInfoManager.h"
#import "CorePlot-CocoaTouch.h"


@interface JJISAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) JJISSleepInfoManager * manager;

@end
