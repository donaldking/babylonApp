//
//  DetailsViewController.m
//  BabylonApp
//
//  Created by Donald King on 05/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "DetailsViewController.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *postBodyTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCommentsLabel;
@property (weak, nonatomic) User *user;
@property (weak, nonatomic) Comment *comment;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation DetailsViewController


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
    if (self.currentPost) {
        self.user = [[User createNewUserInContext:XAppDelegate.managedObjectContext] getUser:self.currentPost.userId];
        self.comment = [Comment createNewPostCommentInContext:XAppDelegate.managedObjectContext];
    }
    [self updateViews];
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

- (void)updateViews
{
    self.usernameLabel.text = [NSString stringWithFormat:@"%@",self.user.username];
    self.postTitleLabel.text = self.currentPost.title;
    self.postBodyTextView.text = self.currentPost.body;
    self.numberOfCommentsLabel.text = [NSString stringWithFormat:@"%@ Comments",[self.comment totalCommentsForPost:self.currentPost.id]];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",AVATAR_BASE_URL,@"100",self.user.email]]];
}


//------------------------------------------------------------------------------
#pragma mark - UIStoryBoard Segue
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toProfileView"]) {
        ProfileViewController *dvc = (ProfileViewController *)[segue destinationViewController];
        dvc.selectedUser = self.user;
    }
}



@end
