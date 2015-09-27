//
//  NetworkManager.m
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "NetworkManager.h"
#import "NetworkingModel.h"

@implementation NetworkManager

NSString *homeURL= @"http://xkcd.com/info.0.json";
NSString *PrefixURL = @"http://xkcd.com/";
NSString *PostfixURL = @"/info.0.json";


+ (instancetype) sharedInstance
{
    static dispatch_once_t once; //make sure to only initialize one instance is ever initialized
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc]init];
    });
    
    return sharedInstance; //always returns that same instance
}

/*
 Function retrieves the data for the latest comic on the XKCD website. The first network call to be made on startup or network error. The call is made to a static address that always returns a json with the latest comic's information. Subsequent calls utilize returned information to build custom URLs
 */
-(void) getLatestComicWithSuccess:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [[NetworkingModel sharedInstance] setHTTPHeader:ACCEPT value:ACCEPT_TYPE2];
    
    
    [[NetworkingModel sharedInstance] genericGet:homeURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        NSLog(@"Dictionary: %@", [dictionary description]);
        
        //set properties
        self.imageURL = [NSURL URLWithString:[dictionary valueForKey:@"img"]];
        self.comicNumber = [dictionary valueForKey:@"num"];
        self.latestComicNumber = self.comicNumber;
        self.comicTitle = [dictionary valueForKey:@"title"];
        
        
        success(task, responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(task,error);
        
    }];

}




/*
 Function retrieves the next comic in the series by construction a specifc URL based on the current comic number index. Returns the latest comic if index is past the latest comic.
 */
-(void) getNextComicWithSuccess:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    //check to see if the latest comic was retrieved and set the needed properties
    if(self.comicNumber ==nil || self.latestComicNumber == nil){
        [self getLatestComicWithSuccess:success failure:failure]; //if not, retrieve the latest
        return;
    }
    
    
    [[NetworkingModel sharedInstance] setHTTPHeader:ACCEPT value:ACCEPT_TYPE2];
    
    NSNumber *num;
    if(self.comicNumber == self.latestComicNumber){
        num = self.latestComicNumber;
    }else{
        num = @([self.comicNumber intValue] + 1);
        
    }
    
    NSString *path = [[PrefixURL stringByAppendingString:[num stringValue]] stringByAppendingString:PostfixURL];
    
    [[NetworkingModel sharedInstance] genericGet: path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //convert to NSDictionary
         NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        //set properties
        self.imageURL = [NSURL URLWithString:[dictionary valueForKey:@"img"]];
        self.comicNumber = [dictionary valueForKey:@"num"];
        self.comicTitle = [dictionary valueForKey:@"title"];

        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(task, error);
    }];
    
    
}



/*
 Function retrieves the previous comic in the series by construction a specifc URL based on the current comic number index. Returns the very first comic if index is <= 0 .
 */
-(void) getPreviousComicWithSuccess:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    //check to see if the latest comic was retrieved and set the needed properties
    if(!self.comicNumber  || !self.comicTitle || !self.latestComicNumber ){
        [self getLatestComicWithSuccess:success failure:failure]; //if not, retrieve the latest
        return;
    }

    
    [[NetworkingModel sharedInstance] setHTTPHeader:ACCEPT value:ACCEPT_TYPE2];
    
    NSNumber *num;
    if(self.comicNumber.integerValue <= 1){
        num = @1;
    }else{
        num = @([self.comicNumber intValue] - 1);
        
    }
    
    NSString *path = [[PrefixURL stringByAppendingString:[num stringValue]] stringByAppendingString:PostfixURL];
    
    [[NetworkingModel sharedInstance] genericGet: path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //convert to NSDictionary
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        //set properties
        self.imageURL = [NSURL URLWithString:[dictionary valueForKey:@"img"]];
        self.comicNumber = [dictionary valueForKey:@"num"];
        self.comicTitle = [dictionary valueForKey:@"title"];
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(task, error);
    }];
    
    
    
}



- (void)getSpecificComicWithNumber:(NSNumber *)number Success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    //check to see if the latest comic was retrieved and set the needed properties
    if(!self.comicNumber  || !self.comicTitle || !self.latestComicNumber ){
        [self getLatestComicWithSuccess:success failure:failure]; //if not, retrieve the latest
        return;
    }
    
    
    [[NetworkingModel sharedInstance] setHTTPHeader:ACCEPT value:ACCEPT_TYPE2];
    
    if(number > self.latestComicNumber || number <= 0){
        number = self.latestComicNumber;
    }

    
    NSString *path = [[PrefixURL stringByAppendingString:[number stringValue]] stringByAppendingString:PostfixURL];
    
    [[NetworkingModel sharedInstance] genericGet: path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //convert to NSDictionary
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        //set properties
        self.imageURL = [NSURL URLWithString:[dictionary valueForKey:@"img"]];
        self.comicNumber = [dictionary valueForKey:@"num"];
        self.comicTitle = [dictionary valueForKey:@"title"];
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(task, error);
    }];
    
}






@end
