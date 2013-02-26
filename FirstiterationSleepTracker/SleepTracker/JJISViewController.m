//
//  JJISViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface JJISViewController ()

@end

@implementation JJISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.statusLabel.text = @"Awake";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)segue
{
    
}


@end
