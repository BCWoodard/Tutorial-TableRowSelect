//
//  GetAndSaveData.m
//  ParseTester
//
//  Created by Arthur Mayes on 3/8/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "GetAndSaveData.h"

static GetAndSaveData *sharedGetAndSave;

@interface GetAndSaveData() {
    NSString *path;
}

@property (nonatomic, strong) NSMutableDictionary *allItems;

@end

@implementation GetAndSaveData

- (id)init
{
    if (self = [super init])
    {
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
        
        
        if (![fileManager fileExistsAtPath:path]) //4
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        }
        
        self.allItems = [[NSMutableDictionary alloc] initWithContentsOfFile:path]; // Dictionary of all Groups
    }
    
    return self;
}

// We are saving only the names of the colleges here, plus any user-generated data

- (NSArray *)getAllFavorites{
    return [self.allItems allKeys];
}
-(void)setFavorite:(NSString *)favorite{// just change to a dictionary when more info needs to be saved
    [self.allItems setObject:[NSMutableDictionary new] forKey:favorite];// save an empty dictionary
    [self.allItems writeToFile:path
                    atomically:YES];
}
- (NSArray *)getFavoriteForKey:(NSString *)key{
    return [self.allItems objectForKey:key];
}
- (void)removeFavoriteForKey:(NSString *)key{
    [self.allItems removeObjectForKey:key];
    [self.allItems writeToFile:path
                    atomically:YES];
}

#pragma mark - All Colleges Data Management
- (void)setAllCollegesArray:(NSArray *)allColleges
{
    [self.allItems setObject:allColleges forKey:@"allColleges"];
    [self.allItems writeToFile:path
                    atomically:YES];
}

- (NSArray *)allCollegesArray
{
    if ([self.allItems objectForKey:@"allColleges"]) {
        return [self.allItems objectForKey:@"allColleges"];
    } else {
        return nil;
    }
}
-(void)deleteAllColleges
{
    [self.allItems removeObjectForKey:@"allColleges"];
    [self.allItems writeToFile:path
                    atomically:YES];
}


+(GetAndSaveData *)sharedGetAndSave
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGetAndSave = [[self alloc] init];
    });
	return sharedGetAndSave;
}

@end
