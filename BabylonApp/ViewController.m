//
//  ViewController.m
//  BabylonApp
//
//  Created by Donald King on 05/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "ViewController.h"
#import "MasterTableViewCell.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

static NSString *masterCellIdentifier = @"masterCell";

@interface ViewController ()<NSFetchedResultsControllerDelegate>
{
    MasterTableViewCell *masterCell;
}
@property (strong, nonatomic, nonnull) NSFetchedResultsController *fetchedResultController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

@end

@implementation ViewController


//------------------------------------------------------------------------------
#pragma mark - Lifecycle
//------------------------------------------------------------------------------


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Posts"];
    
    NSError *error = nil;
    if (![[self fetchedResultController] performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
}


//------------------------------------------------------------------------------
#pragma mark - View Appearances
//------------------------------------------------------------------------------


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


//------------------------------------------------------------------------------
#pragma mark - TableView Datasource
//------------------------------------------------------------------------------

- (MasterTableViewCell *)configureCell:(MasterTableViewCell *)cell ForIndexPath:(NSIndexPath *)indexPath
{
    Post *post = [self.fetchedResultController objectAtIndexPath:indexPath];
    masterCell.postTitle.text = post.title;
    [masterCell.imageView setImageWithURL:[self avatarUrlForUserId:post.userId]];
    return masterCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultController sections] objectAtIndex:section];
    
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    masterCell = [self.tableView dequeueReusableCellWithIdentifier:masterCellIdentifier];
    if(masterCell) {
        [self configureCell:masterCell ForIndexPath:indexPath];
    }
    
    return masterCell;
}


//------------------------------------------------------------------------------
#pragma mark - TableView Delegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailsView" sender:self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//------------------------------------------------------------------------------
#pragma mark - UIStoryBoard Segue
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Do stuff */
    if ([[segue identifier] isEqualToString:@"toDetailsView"]) {
        DetailsViewController *dvc = (DetailsViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Post *selectedPost = (Post *)[self.fetchedResultController objectAtIndexPath:indexPath];
        dvc.currentPost = selectedPost;
    }
}


//------------------------------------------------------------------------------
#pragma mark - Helper
//------------------------------------------------------------------------------


- (NSURL *)avatarUrlForUserId:(NSNumber *)userId
{
    User *user = [[User createNewUserInContext:XAppDelegate.managedObjectContext] getUser:userId];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",AVATAR_BASE_URL,@"100",user.email]];
    
    return url;
}

//------------------------------------------------------------------------------
#pragma mark - Fetched Result Controller
//------------------------------------------------------------------------------

- (NSFetchedResultsController *)fetchedResultController {
    if (_fetchedResultController != nil) {
        return _fetchedResultController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post"
                                              inManagedObjectContext:XAppDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id"
                                                                   ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    _fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:XAppDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultController.delegate = self;
    
    return _fetchedResultController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

@end
