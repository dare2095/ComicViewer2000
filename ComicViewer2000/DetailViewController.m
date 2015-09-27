//
//  DetailViewController.m
//  ComicViewer2000
//
//  Created by Landon Dare
//  Copyright (c) 2015 Landon Dare. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //hide the navigation bar to begin with
    self.navigationController.navigationBar.hidden = @YES;
    
    //set up image view
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.image;
    
    //allow gestures
    self.imageView.userInteractionEnabled = @YES;
    
    //scrollView -setting properties to properly zoom in and out
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.contentSize=CGSizeMake(1280, 960);
    self.scrollView.delegate=self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark gestures
/*  
    function toggles between showing and hiding the navigation bar on the view
 */
- (IBAction)tapped:(UITapGestureRecognizer *)sender {
    self.navigationController.navigationBar.hidden = !(self.navigationController.navigationBar.hidden);
}


/*  
    function allows user to swipe backwards to return to previous view
 */
- (IBAction)swiped:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swiped back");
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:@YES];
}



-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}






@end
