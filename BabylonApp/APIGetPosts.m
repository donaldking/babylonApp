//
//  APIGetPosts.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIGetPosts.h"

@interface APIGetPosts ()

@property (nonatomic, strong) getCompletedResponseBlock callback;

@end

@implementation APIGetPosts

- (void)getAllPostsAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context;
{
    self.callback = response;
    
    [[[APIBase new] getHTTPSessionManager] GET:[NSString stringWithFormat:@"%@/%@",BASE_URL,@"posts"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSDictionary *dic = (NSDictionary *)responseObject;
        [self persistPosts:dic forContext:context];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"Failure: %@",error);
        response(NO,nil,nil);
    }];
}

- (void)persistPosts:(NSDictionary *)posts forContext:(NSManagedObjectContext *)context;
{
    
    for (NSDictionary *p in posts) {
        Post *post = [self createNewPostInContext:context];
        
        post.body = [p valueForKey:@"body"];
        post.id = [p valueForKey:@"id"];
        post.title = [p valueForKey:@"title"];
        post.userId = [p valueForKey:@"userId"];
        
#warning - NOTE, I HAVE NOT AVOIDED DUPLICATE INSERT HERE!
       [self saveContext:context];
    }
    
    if (self.callback != nil) {
        self.callback(YES,nil,nil);
    }
}

- (Post *)createNewPostInContext:(NSManagedObjectContext *)context
{
    Post *post = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
    return post;
}


@end
