//
//  Company+CoreDataProperties.h
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bs;
@property (nullable, nonatomic, retain) NSString *catchPhrase;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
