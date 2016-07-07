//
//  ViewController.h
//  BabylonApp
//
//  Created by Donald King on 05/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic, nonnull) IBOutlet UITableView *tableView;

@end

