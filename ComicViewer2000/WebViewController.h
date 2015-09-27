//
//  WebViewController.h
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "ViewController.h"

@interface WebViewController : ViewController <UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;

/* function returns the user to the previous veiw */
- (IBAction)doneButtonPressed:(id)sender;

/* function set the webview url to the previous url*/
- (IBAction)backButtonPressed:(id)sender;


@property NSURL *currentURL;
@property NSMutableArray *backStack; //used to keep track of recent browser history
@property BOOL userAction;   //action flag used in back button functionailty


@end
