//
//  JJISViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  Main ViewController for the SleepTracker app. Contains buttons for subsequent menus and
//  status (sleeping, awake).

#import <UIKit/UIKit.h>

@interface JJISViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
