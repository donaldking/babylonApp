//
//  Location.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Location *)createNewUserLocationInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"
