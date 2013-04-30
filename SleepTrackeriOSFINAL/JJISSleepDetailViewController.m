//
//  JJISSleepDetailViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/23/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepDetailViewController.h"
#import "JJISEditSleepTimeViewController.h"
#import "JJISSleepTableViewController.h"

@interface JJISSleepDetailViewController ()

@end

@implementation JJISSleepDetailViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EditSleepTime:(id)sender {
}

- (IBAction)unwindToDetailCancel:(UIStoryboardSegue *)segue{
}

- (IBAction)unwindToDetailEdit:(UIStoryboardSegue *)segue{
}

// prepareForSegue passes information to the editing screen for display or back to the TableViewController based on editing.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@""]){
        JJISSleepTableViewController *dest = segue.destinationViewController;
        [dest.tableView reloadData];
    }
    else{
        JJISEditSleepTimeViewController *destination = segue.destinationViewController;
        if([destination view]){
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
            NSString *startDate = self.dateStartLabel.text;
            startDate = [startDate stringByAppendingString:self.startLabel.text];
            // set the labels abd datepicker accordingly
            [dateFormatter setDateFormat:@"EEEE MMMM dd, yyyyhh:mm a"];
            // start date
            NSDate *currDate = [dateFormatter dateFromString:startDate];
            destination.datePicker.date = currDate;
            destination.start = currDate;
            destination.row = self.row;
            destination.nap = self.areWeNapping;
            // end date
            NSString* endDate = self.dateEndLabel.text;
            endDate = [endDate stringByAppendingString:self.endLabel.text];
            NSDate *currEndDate = [dateFormatter dateFromString:endDate];
            destination.end = currEndDate;
            [destination.datePicker setMaximumDate:currEndDate];
        }
    }
}

@end
