//
//  Config.m


#define SERVER_URL @"http://clients.oneterallc.com/weather"
//#define SERVER_URL @"http://doo.life/doo/index.php"
//#define SERVER_URL @"http://tunib.com"


//#define TEMP_SERVER_URL @"http://demo.thesparxitsolutions.com/css4855/wp-content/uploads/"
#define TEMP_SERVER_URL @"http://www.doothings.com/wp-content/uploads/"

//*************** Doo define 16 Dec 2015 ***********************//

#define CHTwitterCoverViewHeight 170

#define API_KEY @"123456"
#define API_URL (SERVER_URL @"/api")
#define API_URL_USER_REGISTER (SERVER_URL @"/api/user_register")
#define API_URL_TAG_SHOW (SERVER_URL @"/api/tag_show")
#define API_URL_CHANGE_PASSWORD (SERVER_URL @"/api/change_password")
#define API_URL_CHANGE_EMAIL (SERVER_URL @"/api/change_email")
#define API_URL_USER_PHOTO_UPLOAD (SERVER_URL @"/api/user_photo_upload")
#define API_URL_USER_NOTIFICATION (SERVER_URL @"/api/user_notification")
#define API_URL_SHOW_USER (SERVER_URL @"/api/show_user")
#define API_URL_ADD_FRIENDS (SERVER_URL @"/api/add_friends")
#define API_URL_GET_POSTS_IN_CATEGORY (SERVER_URL @"/api/get_posts_in_category.php")
#define API_URL_GET_POST_INFO (SERVER_URL @"/api/get_post_info.php")
#define API_URL_GET_POST_IN_CATEGORY (SERVER_URL @"/api/get_posts_in_category.php")
#define API_URL_SET_USER_LIKE   (SERVER_URL @"/api/set_user_like_post.php")
#define API_URL_GET_COMMENNT_BY_POST_ID (SERVER_URL @"/api/get_comment_by_post_id.php")
#define API_URL_SET_NEW_COMMENT (SERVER_URL @"/api/set_new_comment.php")



// **************** Doo app **************************************//
#define API_URL_USER_RETRIEVE_PASSWORD (SERVER_URL @"/api/user_retrieve_password")
#define API_URL_USER_LOGOUT (SERVER_URL @"/api/user_logout")
#define API_URL_EXPLORE_BARKS (SERVER_URL @"/api/explore_barks")
#define API_URL_LIKE_BARKS (SERVER_URL @"/api/like_barks")
#define API_URL_BARK_STAT (SERVER_URL @"/api/bark_stat")
#define API_URL_LIKE_USER (SERVER_URL @"/api/like_user")/Users/admin/Desktop/weatherdemo/Config
#define API_URL_MY_BARKS (SERVER_URL @"/api/my_barks")
#define API_URL_REMOVE_LIKED_BARKS (SERVER_URL @"/api/remove_liked_barks")
#define API_URL_FAVORITE_BARKS (SERVER_URL @"/api/favorite_barks")
#define API_URL_PROFILE_UPDATE (SERVER_URL @"/api/profile_update")
#define API_URL_DISCOVERY_SETTINGS (SERVER_URL @"/api/discovery_settings")
#define API_URL_LOCATION_SETTINGS (SERVER_URL @"/api/location_settings")
#define API_URL_USER_SETTINGS_LOCATION_ID (SERVER_URL @"/api/user_settings_location_id")

// MEDIA CONFIG
#define MEDIA_INTRO_URL (SERVER_URL @"/assets/intro/")
#define MEDIA_INTRO_URL_GET_STARTED @"#getStarted"

#define MEDIA_USER_SELF_DOMAIN_PREFIX @"wf_media_user_"
#define MEDIA_AVATAR_SELF_DOMAIN_PREFIX @"wf_avatar_"
#define MEDIA_BARK_PHOTO_SELF_DOMAIN_PREFIX @"wf_media_bark_photo_"
#define MEDIA_BARK_VIDEO_SELF_DOMAIN_PREFIX @"wf_media_bark_video_"
#define MEDIA_BARK_VIDEO_THUMB_SELF_DOMAIN_PREFIX @"wf_media_bark_video_thumb_"

#define MEDIA_URL (SERVER_URL @"/assets/media/")
#define MEDIA_URL_USERS (SERVER_URL @"/assets/media/users/")
#define MEDIA_URL_BARK_PHOTOS (SERVER_URL @"/assets/media/bark_photos/")
#define MEDIA_URL_BARK_VIDEOS (SERVER_URL @"/assets/media/bark_videos/")
#define MEDIA_URL_BARK_VIDEO_THUMBS (SERVER_URL @"/assets/media/bark_video_thumbs/")

// Settings Config
#define USER_AGE_MIN 18
#define USER_AGE_MAX 80

// Explore Barks Default Config
#define EXPLORE_BARKS_COUNT_DEFAULT @"100"

// Aviary Config
#define kAviaryKey @"j8q6p8efaolydstk"
#define kAviarySecret @"kk4fd7pglcnrgbpd"

// Map View Default Config
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360


// Utility Values
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]
#define M_PI        3.14159265358979323846264338327950288

#define FONT_GOTHAM_NORMAL(s) [UIFont fontWithName:@"GothamRounded-Book" size:s]
#define FONT_GOTHAM_BOLD(s) [UIFont fontWithName:@"GothamRounded-Bold" size:s]


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_6_OR_ABOVE (IS_IPHONE && SCREEN_MAX_LENGTH >= 667.0)
typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

