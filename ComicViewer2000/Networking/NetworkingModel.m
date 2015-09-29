//
//  NetworkingModel.m
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//



#import "NetworkingModel.h"


@implementation NetworkingModel

//Set base URL for networking calls
static NSString *baseURL = @"https://xkcd.com";

//Set Accept header constants
NSString* const ACCEPT = @"Accept";
NSString* const ACCEPT_TYPE1 = @"*/*";
NSString* const ACCEPT_TYPE2 = @"application/json; charset=utf-8";



+ (instancetype) sharedInstance
{
    static dispatch_once_t once; //ensures the code will only ever be exectued one time
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    
    return sharedInstance; //always returns the same instance
} //end sharedInstance


- (void) setHTTPHeader:(NSString*)header value:(NSString*)value
{
    [self.requestSerializer setValue:value forHTTPHeaderField:header];
} //end setHTTPHeader




- (void) genericGet:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //Use AFNetworking logic to create a generic GET method
    [self GET:pathString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
} //end genericGet


@end
