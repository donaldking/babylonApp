//
//  User+CoreDataProperties.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *website;
@property (nullable, nonatomic, retain) NSOrderedSet<Post *> *posts;
@property (nullable, nonatomic, retain) Address *address;
@property (nullable, nonatomic, retain) Company *company;
@property (nullable, nonatomic, retain) Location *location;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(Post *)value inPostsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPostsAtIndex:(NSUInteger)idx;
- (void)insertPosts:(NSArray<Post *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePostsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPostsAtIndex:(NSUInteger)idx withObject:(Post *)value;
- (void)replacePostsAtIndexes:(NSIndexSet *)indexes withPosts:(NSArray<Post *> *)values;
- (void)addPostsObject:(Post *)value;
- (void)removePostsObject:(Post *)value;
- (void)addPosts:(NSOrderedSet<Post *> *)values;
- (void)removePosts:(NSOrderedSet<Post *> *)values;

@end

NS_ASSUME_NONNULL_END
