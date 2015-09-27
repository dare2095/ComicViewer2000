//
//  ViewController.m
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController


/* 
 set up work done here, sends the intial http request whose response object is used to help make subsequent call to the website
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    //set default image
    self.mainWindow.image = [UIImage imageNamed:@"xkcd-logo"];
    self.mainWindow.contentMode = UIViewContentModeScaleAspectFit;
    [self.mainWindow setUserInteractionEnabled:@YES];
    
    // set up imageview
    if([[NetworkManager sharedInstance] imageURL] ){
        //keep the current image if the comic has already been set
        [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
    }else{
        //retrieve the latest comic in the series on the first start up
        [[NetworkManager sharedInstance] getLatestComicWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self imageHandlerWithError:error];

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark buttons

/*
 button press prompts application to fetch next comic based with a url constructed from the current latest comic on the website. Retrieves the next comic in the series or returns the latest comic if already at the latest index
 */
- (IBAction)nextComic:(id)sender {
    NSLog(@"retreiving Next Comic");
    [[NetworkManager sharedInstance] getNextComicWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self imageHandlerWithError:error];
    }];
}


/*
 button press prompts application to fetch next comic based with a url constructed from the current latest comic on the website. Retrieves the previous comic in the series or returns the first ever comic if alreay at the beginning of the index
 */
- (IBAction)previousComic:(id)sender {
    NSLog(@"retreiving Previous Comic");
    
    [[NetworkManager sharedInstance] getPreviousComicWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
       [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self imageHandlerWithError:error];
    }];
    
}

- (IBAction)randomComic:(id)sender {
    NSLog(@"retrieving Random comic");
    NSInteger latest = [[[NetworkManager sharedInstance] latestComicNumber] integerValue];
    NSNumber * num = @(( arc4random() % latest ) +1 );
    
    [[NetworkManager sharedInstance] getSpecificComicWithNumber:num Success:^(NSURLSessionDataTask *task, id responseObject) {
        [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self imageHandlerWithError:error];
    }];
}

- (IBAction)firstComic:(id)sender {
    if(![@(1)  isEqual: [[NetworkManager sharedInstance] comicNumber]]){
        NSLog(@"retrieving first comic");
        [[NetworkManager sharedInstance] getSpecificComicWithNumber:@(1) Success:^(NSURLSessionDataTask *task, id responseObject) {
            [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self imageHandlerWithError:error];
        }];

    }
    
}

- (IBAction)lastComic:(id)sender {
    if([[NetworkManager sharedInstance] latestComicNumber] != [[NetworkManager sharedInstance] comicNumber])
    {
        NSLog(@"retrieving latest comic");
        [[NetworkManager sharedInstance] getLatestComicWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            [self imageHandlerWithURL:[[NetworkManager sharedInstance] imageURL]];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self imageHandlerWithError:error];
            
        }];
    }


}


#pragma mark image handling
/*
 Steps to setting an image from a specific resource location
 */
-(void) imageHandlerWithURL:(NSURL *)location{
    
    self.comicData = [NSData dataWithContentsOfURL:location];
    self.comic = [UIImage imageWithData:self.comicData];

    
    if(self.comicData == nil){  //if not connected to a network, or image not returned
        [self imageHandlerWithError:nil];
    }else{
        
        self.mainWindow.image = self.comic;
        //set title and other attributes
        NSString *title = [[[NetworkManager sharedInstance] comicNumber] stringValue];
        title = [title stringByAppendingString:@" - "];
        title = [title stringByAppendingString:[[NetworkManager sharedInstance] comicTitle]];
        self.navigationController.navigationBar.topItem.title = title;
        
    }
}


/*
 steps to be taken if an image is not loaded
 */
-(void)imageHandlerWithError:(NSError *)error{
    
    //print out error if applicable
    if(error){
        NSLog(@"ERROR : %@",error);
    }
    
    //set the error image in the main view
    NSNumber *x = @(arc4random() % 8);
    NSString *str = [@"error" stringByAppendingString:x.stringValue];
    
    self.comic =  [UIImage imageNamed:str];
    self.mainWindow.image = self.comic;
    //set title and other attributes
    self.navigationController.navigationBar.topItem.title =  @"ERROR";

    
    
}




#pragma mark gestures and segues

/*  
    function recognizes tap gesture and sends user to a fullscreen view with the same comic. this view allows for the comic to be zoomed in and out of for a closer inspection.
 */
- (IBAction)tapGesture:(UIGestureRecognizer *)sender {
    
    NSLog(@"Tapped that");
    [self performSegueWithIdentifier:@"tapSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([@"tapSegue" isEqualToString: segue.identifier] ){
        DetailViewController *detail = [segue destinationViewController];
        detail.image = self.comic;  //set the image property to the current comic
        
    }
}

-(BOOL) shouldAutorotate{
    return @NO;
}










@end
