//
//  tutTableIndexAppDelegate.m
//  TableRowSelect
//
//  Created by Brad Woodard on 5/9/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "tutTableIndexAppDelegate.h"
#import <Parse/Parse.h>
#import "GetAndSaveData.h"

@interface tutTableIndexAppDelegate ()
@property (nonatomic) int alphabetCount;

@end

@implementation tutTableIndexAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.alphabetCount = 0;
    [Parse setApplicationId:@"VPqtYfOVGx5nrjSPS2YWFeMKgepVWbDEw5EX4q7H"
                  clientKey:@"I4APiwD5Exizl3PiLcsajY7Tgqz9vmTNbDOOb9Yd"];
    [Parse offlineMessagesEnabled:YES];
    [Parse errorMessagesEnabled:YES];
    
    // Add mechanism to check for date of last upload to Parse.com, and remove data and re-download if last download date was before last upload date
    // This shouldn't trigger unless we've added colleges, in which case the array count will have changed
    //[[GetAndSaveData sharedGetAndSave] deleteAllColleges];
    
    if (![[GetAndSaveData sharedGetAndSave] allCollegesArray]) {
        NSArray *alphabetArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        
        for (NSString *string in alphabetArray) {
            [self performQueryWithString:string];
        }
    } else {
        self.arrayOfCollegeNames = (NSMutableArray *)[[GetAndSaveData sharedGetAndSave] allCollegesArray];
    }

    return YES;
}


-(NSMutableArray *)arrayOfCollegeNames{
    if (!_arrayOfCollegeNames) _arrayOfCollegeNames = [NSMutableArray new];
    return _arrayOfCollegeNames;
}

-(void)performQueryWithString:(NSString *)string
{
    PFQuery *query = [PFQuery queryWithClassName:@"collegeData"];
    tutTableIndexAppDelegate *__weak weakSelf = self;
    [query whereKey:@"CollegeName" hasPrefix:string];
    query.limit = 1000;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        for (PFObject *dict in objects) {
            [weakSelf.arrayOfCollegeNames addObject:[dict objectForKey:@"CollegeName"]];
        }
        weakSelf.alphabetCount++;
        if (weakSelf.alphabetCount == 26) {
            weakSelf.finalArrayCount = [weakSelf.arrayOfCollegeNames count];
        }
        weakSelf.foundNew = YES;
        weakSelf.foundNew = NO;
    }];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
