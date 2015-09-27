//
//  DetailViewController.h
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "ViewController.h"

@interface DetailViewController : ViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property NSData *imageData;
@property UIImage *image;


/* function responds to tap and show or hides navigation bar */
- (IBAction)tapped:(UITapGestureRecognizer *)sender;

/*  function responds to swipes and returns to previous view */
- (IBAction)swiped:(UISwipeGestureRecognizer *)sender;


@end
