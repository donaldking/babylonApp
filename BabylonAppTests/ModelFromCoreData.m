//
//  ModelFromCoreData.m
//  BabylonApp
//
//  Created by Donald King on 07/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "APIGetUsers.h"
#import "APIGetPosts.h"
#import "APIGetPostComments.h"

@interface ModelFromCoreData : XCTestCase

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ModelFromCoreData

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error = nil;
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error];
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
}

- (void)testUser
{
    [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    APIGetUsers *mockApiGetUsers = [APIGetUsers new];
    
    // Test if changes are pending
    [mockApiGetUsers persistUser:nil forContext:self.managedObjectContext];
    XCTAssertTrue([self.managedObjectContext hasChanges], @"Context must have changes");
    
    // Test if changes are commited
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    XCTAssertFalse([self.managedObjectContext hasChanges], @"Changes should must commit");
}

- (void)testPost
{
    [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
    APIGetPosts *mockApiGetPosts = [APIGetPosts new];
    
    // Test if changes are pending
    [mockApiGetPosts persistPosts:nil forContext:self.managedObjectContext];
    XCTAssertTrue([self.managedObjectContext hasChanges], @"Context must have changes");
    
    // Test if changes are commited
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    XCTAssertFalse([self.managedObjectContext hasChanges], @"Changes should must commit");
}

- (void)testComment
{
    [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.managedObjectContext];
    APIGetPostComments *mockApiGetPostsComments = [APIGetPostComments new];
    
    // Test if changes are pending
    [mockApiGetPostsComments persistPostComment:nil forContext:self.managedObjectContext];
    XCTAssertTrue([self.managedObjectContext hasChanges], @"Context must have changes");
    
    // Test if changes are commited
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    XCTAssertFalse([self.managedObjectContext hasChanges], @"Changes should must commit");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
@end
