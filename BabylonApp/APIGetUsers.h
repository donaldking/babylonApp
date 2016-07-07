//
//  APIGetUsers.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIBase.h"

@interface APIGetUsers : APIBase

- (void)getAllUsersAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context;
- (void)persistUser:(NSDictionary *)users forContext:(NSManagedObjectContext *)context;

@end
