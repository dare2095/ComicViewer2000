//
//  NetworkManager.h
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingModel.h"

@interface NetworkManager : NSObject

+(instancetype) sharedInstance;

@property NSURL *imageURL;

@property NSNumber *comicNumber;

@property NSNumber *latestComicNumber;

@property NSString *comicTitle;


/* Function retrieves the data for the latest comic on the XKCD website. The first network call to be made on startup or network error. */
-(void) getLatestComicWithSuccess: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/* Function retrieves the next comic in the series by construction a specifc URL based on the current comic number index. Returns the latest comic if index is past the latest comic. */
-(void) getNextComicWithSuccess: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/* Function retrieves the previous comic in the series by construction a specifc URL based on the current comic number index. Returns the very first comic if index is <= 0 . */
-(void) getPreviousComicWithSuccess: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/* Function retrieves a specific comic in the series based on the passed number parameter */
-(void) getSpecificComicWithNumber:(NSNumber*) number Success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;





@end
