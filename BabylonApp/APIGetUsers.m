//
//  APIGetUsers.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "APIGetUsers.h"

@interface APIGetUsers ()

@property (nonatomic, copy) getCompletedResponseBlock callback;

@end

@implementation APIGetUsers

- (void)getAllUsersAndCallback:(getCompletedResponseBlock)response forContext:(NSManagedObjectContext *)context
{
    self.callback = response;
    
    [[[APIBase new] getHTTPSessionManager] GET:[NSString stringWithFormat:@"%@/%@",BASE_URL,@"users"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSDictionary *dic = (NSDictionary *)responseObject;
        [self persistUser:dic forContext:context];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"Failure: %@",error);
        response(NO,nil,nil);
    }];
    
}

- (void)persistUser:(NSDictionary *)users forContext:(NSManagedObjectContext *)context;
{
    
    for (NSDictionary *u in users)
    {
        User *user = [self createNewUserInContext:context];
        Address *address = [self createNewUserAddressInContext:context];
        Location *location = [self createNewUserLocationInContext:context];
        Company *company = [self createNewUserCompanyInContext:context];
        
        // Populate address
        address.suite = [u valueForKeyPath:@"address.suite"];
        address.street = [u valueForKeyPath:@"address.street"];
        address.city = [u valueForKeyPath:@"address.city"];
        address.zipCode = [u valueForKeyPath:@"address.zipcode"];
        
        // Populate location
        location.lat = [u valueForKeyPath:@"address.geo.lat"];
        location.lng = [u valueForKeyPath:@"address.geo.lng"];
        
        // Populate company
        company.companyName = [u valueForKeyPath:@"company.name"];
        company.catchPhrase = [u valueForKeyPath:@"catchPhrase"];
        company.bs = [u valueForKeyPath:@"bs"];
        
        user.id = [u valueForKey:@"id"];
        user.name = [u valueForKey:@"name"];
        user.username = [u valueForKey:@"username"];
        user.email = [u valueForKey:@"email"];
        user.phone = [u valueForKey:@"phone"];
        user.website = [u valueForKey:@"website"];
        user.address = address;
        user.location = location;
        user.company = company;
        
#warning - NOTE, I HAVE NOT AVOIDED DUPLICATE INSERT HERE!
        [self saveContext:context];
    }
    
    if (self.callback != nil) {
        self.callback(YES,nil,nil);
    }
}


- (User *)createNewUserInContext:(NSManagedObjectContext *)context
{
    User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    return user;
}

- (Address *)createNewUserAddressInContext:(NSManagedObjectContext *)context
{
    Address *address = (Address *)[NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:context];
    return address;
}

- (Location *)createNewUserLocationInContext:(NSManagedObjectContext *)context
{
    Location *location = (Location *)[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    return location;
}

- (Company *)createNewUserCompanyInContext:(NSManagedObjectContext *)context
{
    Company *company = (Company *)[NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    return company;
}

@end
