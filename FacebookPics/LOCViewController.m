//
//  LOCViewController.m
//  FacebookPics
//
//  Created by Erick Camacho on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LOCViewController.h"


@interface LOCViewController ()

@end

@implementation LOCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
  [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)loginInFB:(id)sender
{
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager setDelegate:self];
  [facebookManager loginWithFacebook];
}

#pragma mark - LOCFacebookManagerDelegate methods
- (void)didLoginToFacebook
{
  [self performSegueWithIdentifier:@"takePicSegue" sender:nil];
  
}

- (void)didNotLoginToFacebook
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                  message:@"Error en login" 
                                                 delegate:nil cancelButtonTitle:@"Aceptar" 
                                        otherButtonTitles:nil];
  [alert show];
}

@end
