//
//  User.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, Company, Location, Post;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (User *)getUser:(NSNumber *)userId;
+ (User *)createNewUserInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
