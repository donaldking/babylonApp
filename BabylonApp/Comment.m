//
//  Comment.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "Comment.h"
#import "Post.h"

@implementation Comment

// Insert code here to add functionality to your managed object subclass

- (NSNumber *)totalCommentsForPost:(NSNumber *)postId
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(postId == %@)", postId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return @(results.count);
}

+ (Comment *)createNewPostCommentInContext:(NSManagedObjectContext *)context
{
    Comment *comments = (Comment *)[NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
    return comments;
}

@end
