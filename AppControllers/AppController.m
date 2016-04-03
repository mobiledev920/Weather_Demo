//
//  AppController.m


#import "AppController.h"

static AppController *_appController;

@implementation AppController

+ (AppController *)sharedInstance {
    static dispatch_once_t predicate;
    if (_appController == nil) {
        dispatch_once(&predicate, ^{
            _appController = [[AppController alloc] init];
        });
    }
    return _appController;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Utility Data
        _appMainColor = RGBA(254, 242, 91, 1.0f);
        _appTextColor = RGBA(41, 43, 48, 1.0f);
        _appThirdColor = RGBA(61, 155, 196, 1.0f);
        _appRedColor = RGBA(241, 97, 97, 1.0f);
        _appGrayColor = RGBA(206, 208, 208, 1.0f);
        _likeRedColor = RGBA(255, 0, 0, 1.0f);
        
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 2;  // there are 5 type of animation
        _vAlert.dRound = 7.0;
        _vAlert.bDestructive = NO;  // for destructive mode
        
        
        _previousVC = nil;
        _selectedUserID = 1;
        _selectedActivityID = 1;
        _selectedCategoryID = 1;
        _inviteImageData = [[NSData alloc] init];
        _invitedPeopleArray = [[NSMutableArray alloc] init];
        _selectedContactCount = 0;
        
        
        // Temp Setting
        _currentUser = [[NSMutableDictionary alloc] init];
        [_currentUser setObject:[NSNumber numberWithInt:1] forKey:@"user_id"];
        [_currentUser setObject:@"admin" forKey:@"user_name"];
        [_currentUser setObject:@"" forKey:@"user_photo_url"];
        
        _menuPages = [[NSMutableArray alloc] init];
        _menuPages = [@[
                        [@{@"tag" : @"1", @"title" : @"EDIT PROFILE", @"icon" : @"menu_edit"} mutableCopy],
                        [@{@"tag" : @"2", @"title" : @"NOTIFICATIONS", @"icon" : @"menu_noti"} mutableCopy],
                        [@{@"tag" : @"3", @"title" : @"INVITE FRIENDS", @"icon" : @"menu_invite"} mutableCopy],
                        [@{@"tag" : @"4", @"title" : @"SETTINGS", @"icon" : @"menu_setting"} mutableCopy],
                        [@{@"tag" : @"5", @"title" : @"FEEDBACK", @"icon" : @"menu_feedback"} mutableCopy],
                        [@{@"tag" : @"6", @"title" : @"ABOUT US", @"icon" : @"menu_about"} mutableCopy],
                        [@{@"tag" : @"7", @"title" : @"TERMS & CONDITIONS", @"icon" : @"menu_terms"} mutableCopy],
                        [@{@"tag" : @"8", @"title" : @"LOGOUT", @"icon" : @"menu_logout"} mutableCopy]
                        ] mutableCopy];

    }
    return self;
}

@end
