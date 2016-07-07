//
//  APIGetPosts.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIBase.h"

@interface APIGetPosts : APIBase

- (void)getAllPostsAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context;
- (void)persistPosts:(NSDictionary *)posts forContext:(NSManagedObjectContext *)context;

@end
