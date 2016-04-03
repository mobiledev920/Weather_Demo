//  AppController.h
//  Created by BE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppController : NSObject

@property (nonatomic, strong) NSMutableArray *introSliderImages, *userall;
@property (nonatomic, strong) NSMutableDictionary *currentUser, *apnsMessage;
@property (nonatomic, strong) NSMutableArray *barks, *myBarks, *likedBarks, *menuPages, *avatars, *favoriteUsers, *statsPeriods;
@property (nonatomic, strong) UIImage *postBarkImage, *editProfileImage;

// Temporary Variables
@property (nonatomic, strong) NSString *currentMenuTag, *avatarUrlTemp;
@property (nonatomic, strong) NSMutableDictionary *currentNavBark, *currentNavBarkStat;
@property (nonatomic, assign) BOOL isFromSignUpSecondPage, isNewBarkUploaded, isMyProfileChanged;
@property (nonatomic, strong) NSString *statsVelocityHistoryPeriod,*user_id,*user_email,*user_image;


// Utility Variables
@property (nonatomic, strong) UIColor *appMainColor, *appTextColor, *appThirdColor,*likeRedColor;
@property (nonatomic, strong) DoAlertView *vAlert;

// Doo coloer
@property (nonatomic, strong) UIColor *appRedColor, *appGrayColor;

// Profile VC & Selected User
@property (nonatomic, strong) UIViewController *previousVC;
@property (nonatomic, assign) NSUInteger selectedUserID;




// Activity Detail Page
@property (nonatomic, assign) NSUInteger selectedActivityID;

@property (nonatomic, strong) NSData *inviteImageData;
@property (nonatomic, strong) NSString *inviteActivityTitle;
@property (nonatomic, strong) NSString *invitePostGuidURL;

@property (nonatomic, strong) NSMutableArray *invitedPeopleArray;
@property (nonatomic, assign) NSUInteger selectedContactCount;

// CategoryActivity Page
@property (nonatomic, assign) NSUInteger selectedCategoryID;

// Invite Page

+ (AppController *)sharedInstance;




@end