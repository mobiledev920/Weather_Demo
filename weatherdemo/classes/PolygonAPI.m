//
//  PolygonAPI.m
//  Polygon_App
//
//  Created by admin on 12/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "PolygonAPI.h"

@implementation PolygonAPI

+ (PolygonAPI *) sharedManager {
    
    static PolygonAPI *sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{@"X-Access-Token":@"ed0b3ea57b15d0a211ec14bf9411bf8b5def6eae" , @"Device-ID":@"sample"};
        sharedManager = [[PolygonAPI alloc] initWithBaseURL:[NSURL URLWithString:PolygonApiBaseUrl] sessionConfiguration:configuration];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sharedManager.requestSerializer setTimeoutInterval:15.0];
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedManager;
}

- (void) getWeather:(NSString *)regionName onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", PolygonApiBaseUrl, regionName];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}


- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"POST url : %@", url);
    NSLog(@"POST param : %@", parameters);
    
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
        NSLog(@"POST success %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"POST error %@", error);
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)GET:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"GET url : %@", url);
    NSLog(@"GET param : %@", parameters);
    
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"GET success : %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"GET error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        //[SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)PUT:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"PUT url : %@", url);
    NSLog(@"PUT param : %@", parameters);
    
    [self PUT:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"PUT success : %@", responseObject);
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"PUT error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void) POSTImage : (NSString *)url
        parameters : (NSMutableDictionary *) parameters
constructingBodyWithBlock : (constructingBodyWithBlock)bodyBlock
         onSuccess : (SuccessBlock)completionBlock
         onFailure : (FailureBlock) failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"PUT url : %@", url);
    NSLog(@"PUT param : %@", parameters);
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        
        bodyBlock(formData);
        
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        NSLog(@"PUT success : %@", responseObject);
        completionBlock(responseObject);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"PUT error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        //        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);

    }];
}


@end
