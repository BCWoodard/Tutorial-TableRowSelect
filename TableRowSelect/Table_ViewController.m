//
//  Table_ViewController.m
//  TableRowSelect
//
//  Created by Brad Woodard on 5/9/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "Table_ViewController.h"
#import "GetAndSaveData.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "tutTableIndexAppDelegate.h"

@interface Table_ViewController ()

@end

@implementation Table_ViewController
@synthesize stateIndex, listOfStates;
BOOL isSelected = NO;

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

    listOfStates = [[NSMutableArray alloc] initWithObjects:
                    @"Alabama",
                    @"Alaska",
                    @"Arizona",
                    @"Arkansas",
                    @"California",
                    @"Colorado",
                    @"Connecticut",
                    @"Delaware",
                    @"Florida",
                    @"Georgia",
                    @"Hawaii",
                    @"Idaho",
                    @"Illinois",
                    @"Indiana",
                    @"Iowa",
                    @"Kansas",
                    @"Kentucky",
                    @"Louisiana",
                    @"Maine",
                    @"Maryland",
                    @"Massachusetts",
                    @"Michigan",
                    @"Minnesota",
                    @"Mississippi",
                    @"Missouri",
                    @"Montana",
                    @"Nebraska",
                    @"Nevada",
                    @"New Hampshire",
                    @"New Jersey",
                    @"New Mexico",
                    @"New York",
                    @"North Carolina",
                    @"North Dakota",
                    @"Ohio",
                    @"Oklahoma",
                    @"Oregon",
                    @"Pennsylvania",
                    @"Rhode Island",
                    @"South Carolina",
                    @"South Dakota",
                    @"Tennessee",
                    @"Texas",
                    @"Utah",
                    @"Vermont",
                    @"Virginia",
                    @"Washington",
                    @"West Virginia",
                    @"Wisconsin",
                    @"Wyoming",
                    nil];

    // Create the index for the tableView
    stateIndex = [[NSMutableArray alloc] init];
    
    // Iterate thru listOfStates and add each unique first letter to stateIndex
    for (int i = 0; i < [listOfStates count]; ++i) {
        
        // Get the first character (0 character) of each state in listOfStates
        char alphabet = [[listOfStates objectAtIndex:i] characterAtIndex:0];
        NSString *uniChar = [NSString stringWithFormat:@"%c", alphabet];
        
        // If character is not in our stateIndex array...
        if (![stateIndex containsObject:uniChar]) {
            // Add it
            [stateIndex addObject:uniChar];
        }
    }
    
    self.title = @"United States";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Display the table index
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return stateIndex;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [stateIndex count];
}


// Display a header for each section (i.e. the initial character)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Return the letter at the corresponding index for each section
    return [stateIndex objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    // Get the initial character for each section
    NSString *sectionLetter = [stateIndex objectAtIndex:section];
    
    // Get all the states beginning with that character
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", sectionLetter];
    NSArray *statesInSection = [listOfStates filteredArrayUsingPredicate:predicate];
    
    return [statesInSection count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Display the states in the correct cells for each section
    // Get the letter of the current section
    NSString *sectionLetter = [stateIndex objectAtIndex:[indexPath section]];
    
    // Get all the states beginning with that section letter
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", sectionLetter];
    NSArray *statesInSection = [listOfStates filteredArrayUsingPredicate:predicate];
    
    // if there are states to display, set the textLabel equal to the corresponding value from statesInSection
    if ([statesInSection count] > 0) {
        // Retrieve the states from the statesInSectionArray and display
        cell.textLabel.text = [statesInSection objectAtIndex:indexPath.row];
    }

    // Configure the cell...
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Display the states in the correct cells for each section
    // Get the letter of the current section
    NSString *sectionLetter = [stateIndex objectAtIndex:[indexPath section]];
    
    // Get all the states beginning with that section letter
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", sectionLetter];
    NSArray *statesInSection = [listOfStates filteredArrayUsingPredicate:predicate];

    NSString *selectedCollege = [statesInSection objectAtIndex:indexPath.row];
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedRow];
    
    if (!isSelected) {
            NSString *alertMSG = [[NSString alloc] initWithFormat:@"Add %@ to Favorites?", selectedCollege];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your Selection"
                                                                message:alertMSG
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            isSelected = YES;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        } else {
            NSString *alertMSG = [[NSString alloc] initWithFormat:@"Remove %@ from Favorites?", selectedCollege];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your Selection"
                                                                message:alertMSG
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            cell.accessoryType = UITableViewCellAccessoryNone;
            isSelected = NO;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
