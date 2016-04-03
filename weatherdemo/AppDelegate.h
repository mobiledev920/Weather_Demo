//
//  AppDelegate.h
//  weatherdemo
//
//  Created by admin on 2/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocalityDelegate

-(void)didGetLocality:(NSDictionary *)locality;
-(void)didCancelLocality;
-(void)didGetLocation:(CLLocation*)location;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)appDelegate;

// Location Manager
@property(nonatomic,strong) CLLocationManager* locationManager;
@property (nonatomic, strong) id<LocalityDelegate> localityDelegate;
@property(nonatomic,assign) BOOL needGetLocation;

// Get GPS Location
- (void)setLocalityDelegate:(id<LocalityDelegate>)localityDelegate;
- (void)getLocality:(NSString*)message;
- (CLLocation*) getLocation;


@end

