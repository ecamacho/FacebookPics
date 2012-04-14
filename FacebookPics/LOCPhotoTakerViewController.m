//
//  LOCPhotoTakerViewController.m
//  FacebookPics
//
//  Created by Erick Camacho on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LOCPhotoTakerViewController.h"

#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface LOCPhotoTakerViewController ()

- (void)requestUserData;
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end

@implementation LOCPhotoTakerViewController

@synthesize imageView;
@synthesize postButton;
@synthesize takePicButton;
@synthesize imagePickerController;
@synthesize spinner;
@synthesize avatarImageView;
@synthesize welcomeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.spinner setHidden:YES];
  [self.avatarImageView.layer setCornerRadius:7.0f];
  [self.avatarImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
  [self.avatarImageView.layer setBorderWidth:2.0f];
  [self.avatarImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
  [self.avatarImageView.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
  [self.avatarImageView.layer setShadowOpacity:0.7f];
  [self.avatarImageView setClipsToBounds:YES];
  
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self requestUserData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)requestUserData
{
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager setDelegate:self];
  [facebookManager requestUserData];
}

- (IBAction)takePic:(id)sender
{
 self.imagePickerController = [[UIImagePickerController alloc] init];
 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
    
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self.imagePickerController setShowsCameraControls:YES];
    
  }
  [self.imagePickerController setDelegate:self];
  
  [self presentModalViewController:self.imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];  
	[self.imageView setImage:image];  	
  [self.takePicButton setHidden:YES];
  [self.postButton setHidden:NO];
	[self dismissModalViewControllerAnimated:YES];
  

}

- (IBAction)postPic:(id)sender
{
  [self.spinner setHidden:NO];
  [self.spinner startAnimating];
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  [params setObject:self.imageView.image forKey:@"source"];
  [params setObject:@"Posted from Cocoaheads Mexico" forKey:@"message"];
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager setDelegate:self];
  [facebookManager postPhoto:params];
}

- (IBAction)logout:(id)sender
{
  LOCFacebookManager *facebookManager = [LOCFacebookManager sharedInstance];
  [facebookManager setDelegate:self];
  [facebookManager logoutFromFacebook];
}

#pragma mark - LOCFacebookManagerDelegate methods

- (void)didFoundUserData:(NSDictionary *)userData
{
  NSLog(@"userData %@", userData);
  [self.welcomeLabel setText:[NSString stringWithFormat:@"Bienvenido %@", [userData objectForKey:@"name"]]];
  NSURL *avatarImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", [userData objectForKey:@"id"]]];
  [self.avatarImageView setImageWithURL:avatarImageUrl];
}

- (void)didPostPhoto 
{
  [self.spinner stopAnimating];
  [self showAlertWithTitle:@"Foto subida" andMessage:@"Se ha subido la foto a tu Facebook"];
}

- (void)errorInFBRequest:(NSString *)error
{
  [self.spinner stopAnimating];
  [self showAlertWithTitle:@"Error" andMessage:[NSString stringWithFormat:@"Ocurrió un error: %@", error]];
}
 
- (void)didLogout
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - utility methods

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                  message:message 
                                                 delegate:self 
                                        cancelButtonTitle:@"Aceptar" 
                                        otherButtonTitles:nil];
  [alert show];
}
@end
