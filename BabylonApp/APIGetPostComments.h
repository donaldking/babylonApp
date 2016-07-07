//
//  APIGetPostComments.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIBase.h"

@interface APIGetPostComments : APIBase

- (void)getAllPostCommentsAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context;
- (void)persistPostComment:(NSDictionary *)comments forContext:(NSManagedObjectContext *)context;

@end
