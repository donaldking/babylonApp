//
//  APIBase.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Post.h"
#import "User.h"
#import "Address.h"
#import "Location.h"
#import "Company.h"
#import "Comment.h"

typedef void(^getCompletedResponseBlock) (BOOL success, id completionResponse, NSError *error);

#define BASE_URL @"http://jsonplaceholder.typicode.com"
#define AVATAR_BASE_URL @"https://api.adorable.io/avatars"

@interface APIBase : NSObject

-(AFHTTPSessionManager*)getHTTPSessionManager;
- (BOOL)saveContext:(NSManagedObjectContext *)context;

@end
