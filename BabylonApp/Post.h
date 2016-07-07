//
//  Post.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User;

NS_ASSUME_NONNULL_BEGIN

@interface Post : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (void)fetchPostsFromAPI;

@end

NS_ASSUME_NONNULL_END

#import "Post+CoreDataProperties.h"
