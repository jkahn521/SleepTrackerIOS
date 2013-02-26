//
//  JJISSleepTableViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/23/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepTableViewController.h"
#import "JJISSleepDetailViewController.h"
#import "JJISAppDelegate.h"
#import "JJISSleepInfo.h"
#define kCellIdentifier @"Cell Identifier"

@interface JJISSleepTableViewController ()
@property (strong, nonatomic) NSMutableArray *ourData;
@end

@implementation JJISSleepTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ourData = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate.manager getNumEntries];
}

//  Sets the sleep entries text displayed to their associated start dates.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSArray* dateStrings = [appDelegate.manager getInfo:indexPath.row];
    
    cell.textLabel.text = dateStrings[0];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Unwind"]) {
        
    }
    else {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSArray* infoStrings = [appDelegate.manager getInfo:indexPath.row];
        JJISSleepDetailViewController *destination = segue.destinationViewController;
        if ([destination view]) {
            destination.dateLabel.text = infoStrings[0];
            destination.startLabel.text = infoStrings[1];
            destination.endLabel.text = infoStrings[2];
            destination.durationLabel.text = infoStrings[3];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
