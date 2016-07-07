//
//  APIGetPostComments.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIGetPostComments.h"

@interface APIGetPostComments ()

@property (nonatomic, copy) getCompletedResponseBlock callback;
@end

@implementation APIGetPostComments

- (void)getAllPostCommentsAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context
{
    self.callback = response;
    
    [[[APIBase new] getHTTPSessionManager] GET:[NSString stringWithFormat:@"%@/%@",BASE_URL,@"comments"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSDictionary *dic = (NSDictionary *)responseObject;
        [self persistPostComment:dic forContext:context];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"Failure: %@",error);
        response(NO,nil,nil);
    }];
}

- (void)persistPostComment:(NSDictionary *)comments forContext:(NSManagedObjectContext *)context;
{
    
    for (NSDictionary *c in comments) {
        Comment *comment = [self createNewPostCommentInContext:context];
        
        comment.postId = [c valueForKey:@"postId"];
        comment.id = [c valueForKey:@"id"];
        comment.name = [c valueForKey:@"name"];
        comment.email = [c valueForKey:@"email"];
        comment.body = [c valueForKey:@"body"];
        
#warning - NOTE, I HAVE NOT AVOIDED DUPLICATE INSERT HERE!
        [self saveContext:context];
    }
    
    if (self.callback != nil) {
        self.callback(YES,nil,nil);
    }
}

- (Comment *)createNewPostCommentInContext:(NSManagedObjectContext *)context
{
    Comment *comments = (Comment *)[NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
    return comments;
}

@end
