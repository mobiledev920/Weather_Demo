//
//  PolygonAPI.h
//  Polygon_App
//
//  Created by admin on 12/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <AFNetworking.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"

#define PolygonApiBaseUrl                       @"http://api.wunderground.com/api/5ecd6b933b1f04a5/conditions/"
#define PolygonApiRestricID                     @"/locations/get_location"

typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(NSInteger statusCode, id json);
typedef void (^constructingBodyWithBlock) (id<AFMultipartFormData> formData);

@interface PolygonAPI : AFHTTPSessionManager


+ (PolygonAPI *) sharedManager;

- (void) getWeather : (NSString *) regionName
           onSuccess:(SuccessBlock) completionBlock
           onFailure:(FailureBlock) failureBlock;

- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock;


@end
