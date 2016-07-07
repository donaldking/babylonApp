//
//  APIBase.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIBase.h"

@implementation APIBase

- (AFHTTPSessionManager*)getHTTPSessionManager
{
    /*
     * Override AFNetworking default security policy
     * so self signed certs can be accepted
     */
    AFSecurityPolicy *sPolicy = [AFSecurityPolicy new];
    [sPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    [manager setSecurityPolicy:sPolicy];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    return manager;
    
}

- (BOOL)saveContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error saving post!: %@",error);
        return NO;
    }
    else
        return YES;
}

@end
