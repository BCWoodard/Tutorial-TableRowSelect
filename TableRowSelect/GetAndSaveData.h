//
//  GetAndSaveData.h
//  ParseTester
//
//  Created by Arthur Mayes on 3/8/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAndSaveData : NSObject
+ (GetAndSaveData *)sharedGetAndSave;

- (NSArray *)getAllFavorites;
- (void)setFavorite:(NSArray *)favorite;
- (NSArray *)getFavoriteForKey:(NSString *)key;
- (void)removeFavoriteForKey:(NSString *)key;

- (void)setAllCollegesArray:(NSArray *)allColleges;
- (NSArray *)allCollegesArray;
-(void)deleteAllColleges;
@end
