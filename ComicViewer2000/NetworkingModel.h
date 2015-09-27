//
//  NetworkingModel.h
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@interface NetworkingModel : AFHTTPSessionManager

+ (instancetype) sharedInstance;

//Declare 'Accept' header constants
extern NSString* const ACCEPT;
extern NSString* const ACCEPT_TYPE1;
extern NSString* const ACCEPT_TYPE2;
extern NSString* const ACCEPT_TYPE3;
extern NSString* const ACCEPT_TYPE4;

//Declare networking action constants
typedef NS_ENUM(NSInteger, CallType) {
    GET,
    PUT,
    POST,
    DELETE
};


/* Sets an HTTP request header with the given value. */
- (void) setHTTPHeader:(NSString*)header value:(NSString*)value;

/* function processes simple get requests */
- (void) genericGet:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end

