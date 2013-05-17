//
//  tutTableIndexAppDelegate.h
//  TableRowSelect
//
//  Created by Brad Woodard on 5/9/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutTableIndexAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *arrayOfCollegeNames;
@property (nonatomic) int finalArrayCount;
@property (nonatomic) BOOL foundNew;

@end
