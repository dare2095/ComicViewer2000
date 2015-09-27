//
//  ViewController.h
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mainWindow;
@property NSData *comicData;
@property UIImage *comic;

/* function retrieves the next comic in the series */
- (IBAction)nextComic:(id)sender;

/* function retrieves the previous comic in the series*/
- (IBAction)previousComic:(id)sender;

/* function retrieves a random comic */
- (IBAction)randomComic:(id)sender;

/* function retrieves the first comic in the series */
- (IBAction)firstComic:(id)sender;

/* function retrieves the latest comic in the series */
- (IBAction)lastComic:(id)sender;

/* function segues into new full screen view with resizeable version of current comic */
- (IBAction)tapGesture:(UIGestureRecognizer *)sender;

/* function to centralize all action to be taken when a comic's url is obtained */
-(void)imageHandlerWithURL: (NSURL*) location;

/*  function to centralize all action to be taken when an image's url cannot be obtained */
-(void)imageHandlerWithError: (NSError*) error;


@end

