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

- (IBAction)unwindToHome:(UIStoryboardSegue *)segue
{
    
}


@end
