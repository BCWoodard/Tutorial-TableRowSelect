//
//  Table_ViewController.h
//  TableRowSelect
//
//  Created by Brad Woodard on 5/9/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Table_ViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *listOfStates;
@property (strong, nonatomic) NSMutableArray *stateIndex; // stores the initial character of each state

@end
