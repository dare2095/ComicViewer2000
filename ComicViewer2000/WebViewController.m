//
//  WebViewController.m
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "WebViewController.h"
#import "NetworkManager.h"

@interface WebViewController ()

@end


static NSString *startURL = @"http://xkcd.com/";


@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *num = [[NetworkManager sharedInstance] comicNumber];
    NSString *comicURL = [startURL stringByAppendingString:[[num stringValue] stringByAppendingString:@"/"]];

    //load xkcd.com
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:comicURL]]];
    self.webView.scalesPageToFit =@YES;
    
    //set delegate
    self.webView.delegate = self;
    
    //set up back button
    self.backStack = [[NSMutableArray alloc] init];
    self.userAction = NO;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark navigation;

/* 
 function returns the user to the previous veiw 
 */
- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:@YES completion:nil];
}

/* 
 function set the webview url to the previous url, utilizes a mutable array in the place of a stack to keep track of the users browser history.
 */
- (IBAction)backButtonPressed:(id)sender {
    if(self.backStack.count !=0){
        NSURL *back = [self.backStack objectAtIndex:0];
        [self.backStack removeObjectAtIndex:0];
        self.userAction = NO;
        [self.webView loadRequest:[NSURLRequest requestWithURL:back]];
    }

    
}

/* 
  overriden delegate function used for back button functionality
 */
-(void) webViewDidFinishLoad:(UIWebView *)webView  {
    
    if(self.userAction){ //if triggered by the back button, dont save url
        [self.backStack insertObject:self.currentURL atIndex:0]; //otherwise, store previous address
    }
    self.userAction =YES;
    self.currentURL =webView.request.URL.absoluteURL;

}



@end
