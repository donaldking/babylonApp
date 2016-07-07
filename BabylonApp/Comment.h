//
//  Comment.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post;

NS_ASSUME_NONNULL_BEGIN

@interface Comment : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (NSNumber *)totalCommentsForPost:(NSNumber *)postId;
+ (Comment *)createNewPostCommentInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Comment+CoreDataProperties.h"
