//
//  LOCPhotoTakerViewController.h
//  FacebookPics
//
//  Created by Erick Camacho on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LOCFacebookManager.h"


@interface LOCPhotoTakerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,
LOCFacebookManagerDelegate>


@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) IBOutlet UIButton *takePicButton;

@property (nonatomic, strong) IBOutlet UIButton *postButton;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;


- (IBAction)takePic:(id)sender;

- (IBAction)postPic:(id)sender;

- (IBAction)logout:(id)sender;

@end
