//
//  User.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "User.h"
#import "Address.h"
#import "Company.h"
#import "Location.h"
#import "Post.h"

@implementation User

// Insert code here to add functionality to your managed object subclass

- (User *)getUser:(NSNumber *)userId
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(id == %@)", userId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return (User *)[results lastObject];
}

+ (User *)createNewUserInContext:(NSManagedObjectContext *)context
{
    User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    return user;
}

@end
