//
//  ProfileViewController.m
//  BabylonApp
//
//  Created by Donald King on 06/07/2016.
//  Copyright © 2016 TSK. All rights reserved.
//

#import "ProfileViewController.h"
#import <MapKit/MapKit.h>
#import "Location.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) Location *location;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation ProfileViewController


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
    if (self.selectedUser) {
        self.location = (Location *)self.selectedUser.location;
        [self startLocationManager];
        [self updateViews];
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


- (void)updateViews
{
    self.fullNameLabel.text = self.selectedUser.name;
    self.phoneLabel.text = self.selectedUser.phone;
    self.emailLabel.text = self.selectedUser.email;
    self.usernameLabel.text = self.selectedUser.username;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",AVATAR_BASE_URL,@"100",self.selectedUser.email]]];
}


//------------------------------------------------------------------------------
#pragma mark - Location
//------------------------------------------------------------------------------

- (void)startLocationManager
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self showLocation];
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Failed to authorise location");
            break;
        default:
            break;
    }
}

- (void)showLocation
{
    double lat = [self.location.lat doubleValue];
    double lng = [self.location.lng doubleValue];
    
    CLLocationCoordinate2D coord = {.latitude =  lat, .longitude =  lng};
    MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    MKCoordinateRegion region = {coord, span};
    
    [self.map setRegion:region];
}

@end
