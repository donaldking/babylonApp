//
//  Location.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "Location.h"
#import "User.h"

@implementation Location

// Insert code here to add functionality to your managed object subclass

+ (Location *)createNewUserLocationInContext:(NSManagedObjectContext *)context
{
    Location *location = (Location *)[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    return location;
}

@end
